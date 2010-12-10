class ShowOffSlide
  attr_accessor :components, :content

  SHOWOFF_SLIDE_TYPES = [
                          'subsection',
                          'commandline',
                          'incremental',
                          'center',
                          'command',
                          'small',
                          'full-page',
                          'bullets',
                          'smbullets',
                          'code',
                          'smaller',
                          'execute',
                          'transition='
                        ]

  def initialize(content = '', options = {})
    @components = []
    @options = { :size => 'A4', :layout => :landscape }.merge(options)
    @content = content
  end
  
  def render_on(pdf)
    parse if @components.empty?
    pdf.start_new_page(@options)
    pdf.font_size(20)
    @components.each { |c| c.render_on(pdf) }
  end
  
  private
  
  def parse    
    # Get rid of leading \n characters
    #
    @content.gsub!(/^(\n)*/,'') 

    # Skip aparently blank slides
    #
    return if @content.empty?

    # Pull out presenter notes for displaying at the bottom
    # of the page
    # 
    s =/(\s)?.notes\s(.*)(\n)?/.match(@content)
    if !s.nil?
      @slide_notes = $2
      @content.gsub!(".notes #{@slide_notes}",'')
    else
      @slide_notes = nil
    end

    # Determine the parser to use, based on the keywords shown on the
    # first line of the @content. If none of the special words we're
    # interested in comes up, then default to the StringParser and 
    # we'll try to convert as much MarkDown as possible.
    #
    
    if @content[0,10] =~ /commandline/ || @content[0,10] =~ /command/
      sp = MarkdownPrawn::ShowOffCommandLineParser.new(@content)
    elsif @content[0,30] =~ /center/
      sp = MarkdownPrawn::StringParser.new(@content, :center => true)
    else
      sp = MarkdownPrawn::StringParser.new(@content)
    end

    sp.parse!
    @components = sp.document_structure
    if @slide_notes
      @components << PresenterNotesFragment.new([@slide_notes])
    end
  end

  def default_options
    { :align => :center }
  end

end
