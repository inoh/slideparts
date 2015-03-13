# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'slideparts/version'

Gem::Specification.new do |spec|
  spec.name          = "slideparts"
  spec.version       = Slideparts::VERSION
  spec.authors       = ["ino_h"]
  spec.email         = ["syslink.h.inoue@gmail.com"]
  spec.summary       = "Simple slide generator"
  spec.description   = "Simple slide generator"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end