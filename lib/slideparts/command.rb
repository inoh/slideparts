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
            :DocumentRoot => '_slide',
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
          Dir.glob("*").each do |filepath|
            unless File.basename(filepath)[0] == "_"
              if File.extname(filepath) == ".erb"
                open("_slide/index.html", "w:utf-8") do |f|
                  @slides = File.read(filepath)
                  f.write ERB.new(File.read("_layouts/default.html.erb")).result(binding)
                end
              else
                FileUtils.copy_entry(filepath, File.join("_slide", File.basename(filepath)))
              end
            end
          end
        end
      end
    end
    
  end
end
