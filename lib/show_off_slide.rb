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

    sp = MarkdownPrawn::StringParser.new(@content)
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
