require_relative '../../../spec_helper'

RSpec.describe Languages::ModuleNamespace do

  before :all do
    @moduleNamespace = Languages::ModuleNamespaceData.new("Simple")
  end

  context "Module simple behavior." do
    it "Set name" do
      @moduleNamespace.name = "Abc"
      expect(@moduleNamespace.name).to eq("Abc")
    end
    it "Does not set name" do
      @moduleNamespace = Languages::ModuleNamespaceData.new(nil)
      expect(@moduleNamespace.name).to be_nil
      @moduleNamespace = Languages::ModuleNamespaceData.new(1)
      expect(@moduleNamespace.name).to be_nil
    end
  end

  after :all do
    @moduleNamespace = nil
  end

end
