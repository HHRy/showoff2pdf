class HeadingFragment < MarkdownFragment
  attr_accessor :level
  
    def render_on(pdf_object, options = {})
      arguments = _default_render_options.merge(options)
      pdf_object.move_down(@level * 2)
      pdf_object.text "<b>#{@content.join(' ')}</b>", arguments
      pdf_object.move_down(@level * 2)
    end

  private

    def _default_render_options
      options = { :size => (50 - (10*@level)), :align => :left, :leading => 2, :inline_format => true }
      if Prawn::VERSION =~ /^0.1/ || Prawn::VERSION =~ /^1/
        options.merge({:inline_format => true})
      end
      options
    end
end