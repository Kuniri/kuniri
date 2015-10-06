require_relative '../../spec_helper'

RSpec.describe Languages::Cplusplus::FunctionBehaviorCplusplus do

  before :all do
    @functionBehaviorCplusplus = Languages::Cplusplus::FunctionBehaviorCplusplus.new
  end

  after :all do
    @functionBehaviorCplusplus = nil
  end

end
