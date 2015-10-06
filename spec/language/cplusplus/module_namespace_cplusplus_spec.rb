require_relative '../../spec_helper'

RSpec.describe Languages::Cplusplus::ModuleNamespaceCplusplus do

  before :all do
    @modules = Languages::Cplusplus::ModuleNamespaceCplusplus.new
  end

  after :all do
    @module = nil
  end
end
