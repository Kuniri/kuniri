require_relative '../../spec_helper'

RSpec.describe Languages::Ruby::ExternRequirementRuby do

  before :all do
    @extern = Languages::Ruby::ExternRequirementRuby.new
  end

  context 'Simple case of match' do
    it '"Require", Normal case' do
       result = @extern.get_requirement('require "xpto"')
       expect(result.library).to eq('xpto')
    end

    it '"require_relative", Normal case' do
       result = @extern.get_requirement('require_relative "xpto"')
       expect(result.library).to eq('xpto')
    end
  end

  context 'Find requires with multiple spaces' do
    it 'A lot of space at the end (require)' do
       result = @extern.get_requirement('require "xpto"                ')
       expect(result.library).to eq('xpto')
    end

    it 'A lot of space at the end (require_relative)' do
       result = @extern.get_requirement('require_relative "xpto"       ')
       expect(result.library).to eq('xpto')
    end

    it 'A lot of space at the beginning (require)' do
       result = @extern.get_requirement('require              "xpto"')
       expect(result.library).to eq('xpto')
    end

    it 'A lot of space at the beginning (require_relative)' do
       result = @extern.get_requirement('require_relative            "xpto"')
       expect(result.library).to eq('xpto')
    end

    it 'A lot of space at the beginning and the end (require_relative)' do
       result = @extern.get_requirement('require_relative         "xpto"  ')
       expect(result.library).to eq('xpto')
    end

    it 'A lot of space at the beginning and the end (require)' do
       result = @extern.get_requirement('require         "xpto"  ')
       expect(result.library).to eq('xpto')
    end

  end

  context 'Require with load' do

    before :each do
      @space = Faker::Boolean.boolean ? ' ' * Faker::Number.between(1, 2) : ''
      @loadLineTest = "'#{Faker::Lorem.word + '.rb'}'"
    end

    it 'Basic use of load' do
      libName = Faker::Lorem.word + '.rb'
      result = @extern.get_requirement("load '#{libName}'")
      expect(result.library).to eq(libName)
    end

    it 'load with multiple spaces in the begin' do
      test = @space + ' ' + 'load ' + @loadLineTest
      result = @extern.get_requirement(test)
      expect(result.library).to eq(@loadLineTest)
    end

    it 'load with multiple spaces in the end' do
      test = 'load ' + @loadLineTest + @space + ' '
      result = @extern.get_requirement(test)
      expect(result.library).to eq(@loadLineTest)
    end

    it 'load with multiple spaces' do
      test = @space + ' ' + 'load ' + @loadLineTest + @space + ' '
      result = @extern.get_requirement(test)
      expect(result.library).to eq(@loadLineTest)
    end

    before :each do
      @loadLineTest = ''
      @space = ''
    end

  end

  after :all do
    @extern = nil
  end

end

