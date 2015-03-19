require 'spec_helper'

describe Slideparts::Command do
  [Slideparts::Commands::New, Slideparts::Commands::Build, Slideparts::Commands::Server].each do |subclass|
    it 'has a ' + subclass.inspect do
      expect(Slideparts::Command.subclasses).to include(subclass)
    end
  end
end
