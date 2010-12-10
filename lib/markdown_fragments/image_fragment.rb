require 'net/http'
require 'tmpdir'

class ImageFragment < MarkdownFragment

  def self._page_image_ratio=(value)
    @@_page_image_ratio = value
  end

  def self._page_image_ratio
    @@_page_image_ratio
  end

  def self._image_assets=(value)
    @@_image_assets = value
  end

  def self._image_assets
    @@_image_assets
  end

  def render_on(pdf_object)
    if is_remote_uri?
      filename = @content.first.split('/').last
      file_path = "#{Dir.tmpdir}/#{filename}"
      content = Net::HTTP.get(URI.parse(@content.first))
      File.open(file_path, 'w') do |f|
        f.puts content
      end
    else
      if !ImageFragment._image_assets.nil?
        ImageFragment._image_assets.each do |image|
          if image =~ /#{@content.first}$/
            file_path = image
          end
        end
      else
        file_path = @content.first
      end
    end
    if file_path =~ /.png$/
      width, height = IO.read(file_path)[0x10..0x18].unpack('NN')
    else
      width = JPEG.new(file_path).width 
      height = JPEG.new(file_path).height
    end
    width,height = best_fit(width, height, pdf_object)
    pdf_object.image file_path , :fit => [ width, height], :position => :center
  end

  private

  def is_remote_uri?
    !/^(http:|https:)/.match(@content.first).nil?
  end

  # Calculate the width and height to best fit the
  # image on the page.
  #
  def best_fit(width, height, pdf)
    ph = pdf.bounds.height - page_padding
    pw = pdf.bounds.width - page_padding

    if ImageFragment._page_image_ratio
      iw = width * ImageFragment._page_image_ratio
      ih = height * ImageFragment._page_image_ratio
    else
      iw = width
      ih = height
    end
    iw = pixels_to_points(iw)
    ih = pixels_to_points(ih)

    if ih <= ph && iw <= pw
      return [iw, ih]
    elsif ih > ph
      r = height / width
      ih = (ih - (page_padding * 2))
      iw = ih * r
    elsif iw > pw
      r = width / height
      iw = (iw - (page_padding * 2))
      ih = iw * r
    else
      puts "SHOULD NEXT GET HERE"
      exit(-1)
    end
    return [iw, ih]
  end

  # Work out the page padding later, for not assume that
  # it's 20.
  # 
  def page_padding
    20
  end


  # Very rough way to convert pixels to points, by
  # assuming the we're at 96 DPI. This isn't the most
  # ideal method, but it should be good enough for 
  # sizing images to fit on page correctly.
  #
  def pixels_to_points(pixels)
    pixels * 72 / 96
  end

  # Very rough reversal ov the above
  #
  def points_to_pixels(points)
    points / 72 * 96
  end

end

class JPEG
  attr_reader :width, :height, :bits

  def initialize(file)
    if file.kind_of? IO
      examine(file)
    else
      File.open(file, 'rb') { |io| examine(io) }
    end
  end

private
  def examine(io)
    raise 'malformed JPEG' unless io.getc == 0xFF && io.getc == 0xD8 # SOI

    class << io
      def readint; (readchar << 8) + readchar; end
      def readframe; read(readint - 2); end
      def readsof; [readint, readchar, readint, readint, readchar]; end
      def next
        c = readchar while c != 0xFF
        c = readchar while c == 0xFF
        c
      end
    end

    while marker = io.next
      case marker
        when 0xC0..0xC3, 0xC5..0xC7, 0xC9..0xCB, 0xCD..0xCF # SOF markers
          length, @bits, @height, @width, components = io.readsof
          raise 'malformed JPEG' unless length == 8 + components * 3
        when 0xD9, 0xDA:  break # EOI, SOS
        when 0xFE:        @comment = io.readframe # COM
        when 0xE1:        io.readframe # APP1, contains EXIF tag
        else              io.readframe # ignore frame
      end
    end
  end
end
