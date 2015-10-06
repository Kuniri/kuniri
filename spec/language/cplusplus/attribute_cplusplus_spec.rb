require_relative '../../spec_helper'

RSpec.describe Languages::Cplusplus::AttributeCplusplus do

  before :all do
    @attributeCplusplus = Languages::Cplusplus::AttributeCplusplus.new
  end

  after :all do
    @attributeCplusplus = nil
  end

end