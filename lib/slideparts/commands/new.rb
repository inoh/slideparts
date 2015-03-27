module Slideparts
  module Commands
    class New < Command
      class << self
        def syntax
          ["new"]
        end

        def options
          {}
        end

        def process(args, options = {})
          raise ArgumentError.new('You must specify a path.') if args.empty?

          new_slide_path = File.expand_path(args.join(" "), Dir.pwd)
          FileUtils.mkdir_p new_slide_path
          FileUtils.cp_r slide_template + '/.', new_slide_path
        end
      end
    end
  end
end
