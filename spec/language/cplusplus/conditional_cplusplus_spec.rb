require_relative '../../spec_helper'

RSpec.describe Languages::Cplusplus::ConditionalCplusplus do

  before :each do
    @conditionalCplusplus = Languages::Cplusplus::ConditionalCplusplus.new
  end

  after :each do
    @conditionalCplusplus = nil
  end

end
