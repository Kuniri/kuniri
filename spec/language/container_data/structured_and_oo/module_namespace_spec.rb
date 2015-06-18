require_relative '../../../spec_helper'

RSpec.describe Languages::ModuleNamespace do

  before :all do
    @moduleNamespace = Languages::ModuleNamespaceData.new
  end

  context "Module simple behavior." do
    it "Set name" do
      @moduleNamespace.name = "Abc"
      expect(@moduleNamespace.name).to eq("Abc")
    end
  end

  after :all do
    @moduleNamespace = nil
  end

end
