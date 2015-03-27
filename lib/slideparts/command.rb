module Slideparts
  class Command

    class << self

      def subclasses
        @subclasses ||= []
      end

      def inherited(base)
        subclasses << base
        super(base)
      end

      def slide_template
        File.expand_path("../slide_template", File.dirname(__FILE__))
      end

      def execute
        options = {}
        commands = OptionParser.new do |opt|
          subclasses.map(&:options).inject({}){|ret, option| ret.merge(option)}.each do |key, value|
            opt.on(*value) do |v|
              options[key] = v
            end
          end
        end.parse!

        subclasses.each do |subclass|
          if subclass.syntax.include? commands.first
            subclass.process(commands[1..-1], options)
          end
        end
      end
    end

  end
end
