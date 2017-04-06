require_relative '../../bin/kuniri'
require_relative '../spec_helper'

RSpec.describe read_arguments do


  context 'Source file' do
    it 'Test source arg' do
      ARGV = ["in"]
      options = read_arguments
      expect(options[:source]).to eq('in')
    end
    it 'Default arguments' do
      ARGV = ["in"]
      options = read_arguments
      set_defaults_if_unspecified options
      expect(options[:log]).to eq(STDOUT)
      expect(options[:output]).to eq('in.xml')
      expect(options[:languageType]).to eq('ruby')
    end
  end
end

RSpec.describe read_arguments do
  context 'Extension replacement' do
    it 'Test xml extension insertion' do
      ARGV = ["in.a.b"]
      opt = read_arguments
      set_defaults_if_unspecified opt
      expect(opt[:output]).to eq('in.a.xml')
    end
  end
end

RSpec.describe read_arguments do
  context 'Log definition' do
    it 'Test log definition' do
      ARGV = ["in", "-L", "log"]
      opt = read_arguments
      expect(opt[:log]).to eq("log")
    end
  end
end
