module Slideparts
  module Commands
    class Build < Command
      class << self
        def syntax
          ["b", "build"]
        end

        def process(args, options = {})
          new_slide_path = File.expand_path("_slide", Dir.pwd)
          
          Dir.mkdir new_slide_path unless File.exist? new_slide_path
          Dir.glob("*").each do |filepath|
            unless File.basename(filepath)[0] == "_"
              if File.extname(filepath) == ".haml"
                open(File.join(new_slide_path, File.basename(filepath).gsub(".haml", ".html")), "w:utf-8") do |f|
                  engine = Haml::Engine.new(File.read(filepath))
                  @slides = engine.render
                  f.write ERB.new(File.read("_layouts/default.html.erb")).result(binding)
                end
              else
                FileUtils.copy_entry(filepath, File.join(new_slide_path, File.basename(filepath)))
              end
            end
          end
        end
      end
    end
  end
end
