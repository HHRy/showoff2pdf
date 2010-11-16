class CodeFragment < MarkdownFragment
  attr_accessor :ordered
  
  def render_on(pdf_object, options = {})
    arguments = _default_render_options.merge(options)
    width = ((pdf_object.bounds.width / 100) * 90)
    data = []

    @content.each_with_index do |item, i|
      # Strip any un-needed white space
      #
      item = item.gsub(/\s\s+/,' ')
      data << [ "<font name=\"Courier\">#{item}</font>" ]
    end
 
    pdf_object.table data, arguments.merge({:width => width}) do
       cells.borders = []
    end
    pdf_object.move_down(5) 
  end
  
  def ordered?
    @ordered == true
  end

  private

  def _default_render_options
    options = {:cell_style =>  { :inline_format => true}}
  end  
  
end