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

        case commands.first
        when "s", "server", "serve"
          s = WEBrick::HTTPServer.new({
            :DocumentRoot => '.',
            :Port => options[:port] || 3000
          })
          s.start
        when "new"
          project = commands[1]
          if project
            FileUtils.copy_entry(slide_template, project)
          else
            raise "not assign project"
          end
        when "b", "build"
          Dir.mkdir "_slide" unless File.exist? "_slide"
          slides = open("index.html", "r").read
          puts ERB.new(open("_layouts/default.html.erb","r").read).run
        end
      end
    end
    
  end
end
