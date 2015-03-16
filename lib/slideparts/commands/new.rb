module Slideparts
  module Commands
    class New < Command
      attr_reader :syntax
      def init_with_program(option)
        @syntax = ["new"]
      end
      
      def process(args, options = {})
      end
    end
  end
end
