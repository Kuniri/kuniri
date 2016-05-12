require_relative '../../../spec_helper'

RSpec.describe Languages::VariableAbstract do

  before :each do
    @abstractVariable = Languages::VariableAbstract.new('xpto')
    @abstractVariable.value = 'lalala'
  end

  context 'Verify attributes' do
    it 'Validate name' do
      expect(@abstractVariable.name).to eq('xpto')
    end

    it 'Validate value' do
      expect(@abstractVariable.value).to eq('lalala')
    end

    it 'Validate type' do
      expect(@abstractVariable.type).to eq('')
    end
  end

  after :each do
    @abstractVariable = nil
  end

end
