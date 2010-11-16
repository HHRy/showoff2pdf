class PresenterNotesFragment < MarkdownFragment
  def render_on(pdf)
    pdf.bounding_box([0,50], :width => pdf.bounds.width, :height => 150) do
      pdf.horizontal_rule
      pdf.stroke
      pdf.move_down(5)
      pdf.text "<b>Slide notes:</b> #{@content.first}", :inline_format => true, :size => 8
    end
  end
end
