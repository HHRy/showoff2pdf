require File.dirname(__FILE__) + '/../markdown_fragments.rb'

module MarkdownPrawn

  class ShowOffCommandLineParser < Parser

    def initialize(string_to_convert)
      string_to_convert = string_to_convert.to_s
      @content = detab(string_to_convert.gsub(/\r\n?/, "\n")).strip.split("\n")
      @document_structure = []
    end 

    # When parsing for commandline slides, I make the following
    # assumptions:
    #
    #   1.  There _may_ be a heading present
    #   2.  Each individual line should be treated as just that
    #       and rendered on its own line
    #   3.  There will be no other Markdown elements in the section
    #       such as images or bulleted lists.
    #   4.  All unexpected elements will be either rendered as 
    #       monospaced text as the code fragment, or ignored depending
    #       on where they fall within the document
    #   5.  These sections do not support inline formattig, so no ** or __
    #       notated text will be converted to bold or italic.
    #
    def parse
      code = CodeFragment.new
      @content.each_with_index do |line, index|
        unless /^(#+)(\s?)\S/.match(line).nil?
          hashes = $1.dup
          heading = HeadingFragment.new([line.gsub(hashes,'')])
          heading.level = hashes.length
          @document_structure << heading
          next
        end
        if !/^(=)+$/.match(line).nil?
          heading = HeadingFragment.new([@content[index - 1]])
          heading.level = 1
          @document_structure << heading
          next
        end
        code.content << line
      end
      code.content[0].gsub!(/[#{ShowOffSlide::SHOWOFF_SLIDE_TYPES.join(',')}]/,'')
      @document_structure << code
    end

  end

end
