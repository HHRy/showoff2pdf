class ParagraphFragment < MarkdownFragment

  def render_on(pdf_object, options = {})
    arguments = _default_render_options.merge(options)
    pdf_object.move_down(3)
    pdf_object.text @content.join(' '), arguments
  end

private

  def _default_render_options
    options = { :inline_format => true, :size => 12, :align => :left, :leading => 2 }
    if center
      options = options.merge({ :align => :center })
    end
    options
  end

end
