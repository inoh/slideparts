require 'optparse'
require 'webrick'
require 'fileutils'

module Slideparts
  class Command

    class << self
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
        end
      end
    end
    
  end
end
