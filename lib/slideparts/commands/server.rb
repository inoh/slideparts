module Slideparts
  module Commands
    class Server < Command
      class << self
        def syntax
          ["s", "serve", "server"]
        end

        def options
          {
            port: ["-p [ARGV]", "--port [ARGV]"]
          }
        end

        def process(args, options = {})
          server = WEBrick::HTTPServer.new({
            :DocumentRoot => '_slide',
            :Port => options[:port] || 3000
          })
          trap(:INT){server.shutdown}
          server.start
        end
      end
    end
  end
end
