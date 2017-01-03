require_relative '../../spec_helper'

RSpec.describe Languages::Ruby::VariableBehaviourRuby do

  before :all do
    @varRuby = Languages::Ruby::VariableBehaviourRuby.new('VariableGlobal')
    @attrRuby = Languages::Ruby::VariableBehaviourRuby.new('Attribute')
    @attrRegex = /^\s*(?:@|attr_(?:accessor|reader|writer))(.*)$/
    @varRegex = /^\s*(?:@|@@|\$)(.*)|(\w+\s+=.*)$/
  end

  context 'Some checks with variable.' do

    it 'Capture simple variable.' do
      var = @varRuby.common_declaration('one = 1', @varRegex)
      expect(var['one']).to eq('1')
    end

    it 'Capture simple attribute' do
      attr = @attrRuby.common_declaration('@off', @attrRegex)
      expect(attr['@off']).to eq('nothing')
    end
  end

  context 'Do not detect' do
    it 'Should not detect string with equal in the begining' do
      var = @varRuby.common_declaration('=begin', @varRegex)
      expect(var).to eq({})
    end
  end

  after :all do
    @variableRuby = nil
  end

end
