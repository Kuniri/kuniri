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
      expect(var[0].name).to eq('one')
      expect(var[0].value).to eq('1')
    end

    it 'Capture simple attribute' do
      attr = @attrRuby.common_declaration('attr_accessor off', @attrRegex)
      expect(attr[0].name).to eq('off')
    end
  end

  context 'Do not detect' do
    it 'Wrong parameters' do
      var = @varRuby.common_declaration('xpto', @varRegex)
      expect(var).to be_nil
    end
  end

  after :all do
    @variableRuby = nil
  end

end
