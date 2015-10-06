require_relative '../../spec_helper'

RSpec.describe Languages::Cplusplus::ConstructorCplusplus do

  before :all do
    @constructor = Languages::Cplusplus::ConstructorCplusplus.new
  end

  after :all do
    @constructor = nil
  end

end
