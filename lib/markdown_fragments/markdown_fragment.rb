class MarkdownFragment
  attr_accessor :content
  
  def initialize(content = [])
    @content = content
    @center = false
  end
  
  # Renders the current fragment on the supplied prawn PDF Object. By Default,
  # it will just join content and add it as text - not too useful.
  def render_on(pdf_object)
    pdf_object.text @content.join(' ')
  end

  def center=(value)
    @center = value
  end

  def center
    @center
  end
end
