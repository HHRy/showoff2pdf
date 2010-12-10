summary = "ShowOff slides can now be translated into semi-useful PDF documents for printing out and handing out at your talks, using Markdown Prawn and the Prawn libary." 
description = <<-TXT
  ShowOff2PDF converts ShowOff presentations into PDF files for use
  as handouts or to provide an easy-to-print version of your presentation.

  It was delveoped by Ryan Stenhouse and relies on Prawn and Ryan's
  Markdown Prawn library.

  Documentation is available at http://ryanstenhouse.eu
TXT

Gem::Specification.new do |spec|
  spec.name = "show_off_pdf"
  spec.version = '0.0.3.pre'
  spec.platform = Gem::Platform::RUBY
  spec.files =  Dir.glob("{bin,lib,.}/**/**/*") +
                      ["show_off_pdf.rb","README.md","COPYING.md",'LICENSE', "show_off_pdf.gemspec"]
  spec.require_path = "lib"
  spec.required_ruby_version = '>= 1.8.7'
  spec.required_rubygems_version = ">= 1.3.6"
  spec.test_files = Dir[ "test/*_test.rb" ]
  spec.has_rdoc = false
  spec.author = "Ryan Stenhouse"
  spec.email = "ryan@ryanstenhouse.eu"
  spec.rubyforge_project = "show_off_pdf"
  spec.add_dependency('prawn', '~>0.10')
  spec.add_dependency('showoff', '~>0.3.2')
  
  spec.homepage = "http://ryanstenhouse.eu"
  spec.summary = summary
  spec.description = description
  spec.executables << 'showoff2pdf'
end
