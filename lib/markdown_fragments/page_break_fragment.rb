class PageBreakFragment < MarkdownFragment
  def render_on(pdf_object)
    pdf_object.start_new_page(:size => "A4", :layout => :landscape)
  end
end
