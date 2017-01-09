require_relative '../../spec_helper'

RSpec.describe Languages::VariableGlobal do

  before :all do
    @variableGlobal = Languages::VariableGlobal.new
  end

  context 'Call to get_variable' do
    it 'Expect to raise error' do
      expect{@variableGlobal.get_variable('@variable')}
        .to raise_error(NotImplementedError)
    end
  end

  after :all do
    @variableGlobal = nil
  end

end
