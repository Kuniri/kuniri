require_relative '../../spec_helper'

RSpec.describe Languages::ModuleNamespace do

  context "When not implemented" do
    it "Get module" do
      moduleAbstract = Languages::ModuleNamespace.new
      expect{moduleAbstract.get_module("module Nothing")}.to raise_error(
              NotImplementedError)
    end
  end

end
