require_relative '../../../spec_helper'

RSpec.describe Languages::VariableGlobalData do

  before :all do
    @variableData = Languages::VariableGlobalData.new("abc")
  end

  context "Get name" do
    it "Check correct name" do
      expect(@variableData.name).to eq("abc")

      @variableData.name = "newName"
      expect(@variableData.name).to eq("newName")
    end
  end

  context "Get value" do
    it "Check value" do
      @variableData.value = 1
      expect(@variableData.value).to eq(1)

      @variableData.value = "valueOne"
      expect(@variableData.value).to eq("valueOne")
    end
  end

  context "Get type" do
    it "Check type value" do
      @variableData.type = "array"
      expect(@variableData.type).to eq("array")
    end
  end

  context "When instantiating" do
    it "Does not set name" do
      @variableData = Languages::VariableGlobalData.new(nil)
      expect(@variableData.name).to eq('fakeName')
      @variableData = Languages::VariableGlobalData.new(1)
      expect(@variableData.name).to eq('fakeName')
    end
  end

  after :all do
    @variableData = nil
  end

end
