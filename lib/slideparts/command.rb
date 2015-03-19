require 'optparse'
require 'webrick'
require 'fileutils'
require 'erb'

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
          opt.on("-p [ARGV]", "--port [ARGV]") do |v|
            options[:port] = v
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
