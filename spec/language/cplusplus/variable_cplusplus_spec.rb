require_relative '../../spec_helper'

RSpec.describe Languages::Cplusplus::VariableGlobalCplusplus do

  before :all do
    @variableCplusplus = Languages::Cplusplus::VariableGlobalCplusplus.new
  end

  after :all do
    @variableCplusplus = nil
  end

end
