def require_all(path)
  glob = File.join(File.dirname(__FILE__), path, '*.rb')
  Dir[glob].each do |f|
    require f
  end
end

require 'optparse'
require 'webrick'
require 'fileutils'
require 'erb'
require 'haml'

require "slideparts/version"

module Slideparts
  autoload :Command, 'slideparts/command'
end

require_all 'slideparts/commands'
