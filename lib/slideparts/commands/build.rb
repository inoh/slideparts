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
              if File.extname(filepath) == ".erb"
                open(File.join(new_slide_path, "index.html"), "w:utf-8") do |f|
                  @slides = File.read(filepath)
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
