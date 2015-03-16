module Slideparts
  module Commands
    class Server < Command
      attr_reader :syntax
      def init_with_program(optparse)
        @syntax = ["s", "serve", "server"]
        optparse.on("-p [arg]", "--port [arg]") do |v|
          @port  = v
        end
      end
      
      def process
        s = WEBrick::HTTPServer.new({
          :DocumentRoot => '.',
          :Port => @port || 3000
        })
        s.start
      end
    end
  end
end
