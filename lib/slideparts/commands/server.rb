module Slideparts
  module Commands
    class Server < Command
      class << self
        def syntax
          ["s", "serve", "server"]
        end

        def process(args, options = {})
          s = WEBrick::HTTPServer.new({
            :DocumentRoot => '_slide',
            :Port => options[:port] || 3000
          })
          s.start
        end
      end
    end
  end
end
