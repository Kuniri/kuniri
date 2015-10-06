require_relative '../../spec_helper'

RSpec.describe Languages::Cplusplus::EndBlockCplusplus do

  before :all do
    @endBlock = Languages::Cplusplus::EndBlockCplusplus.new
  end

  after :all do
    @endBlock = nil
  end

end

