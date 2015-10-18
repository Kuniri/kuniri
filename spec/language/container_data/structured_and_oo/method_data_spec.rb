require_relative '../../../spec_helper'

RSpec.describe Languages::MethodData do

  before :each do
    @methodData = Languages::MethodData.new("xpto")
  end

  context "Module simple behavior." do
    it "Set name" do
      @methodData.name = "Abc"
      expect(@methodData.name).to eq("Abc")
    end

    it "Does not set name" do
      @methodData = Languages::MethodData.new(nil)
      expect(@methodData.name).to be_nil
      @methodData = Languages::MethodData.new(1)
      expect(@methodData.name).to be_nil
    end
  end

  context "When method without parameters" do
    it "Method name" do
      @methodData.name = "xpto"
      expect(@methodData.name).to eq("xpto")
    end
  end

  context "When method has parameter" do
    it "Add 1 attributes." do
      @methodData.add_parameters("value1")
      attributes = @methodData.parameters
      expect(attributes).to match_array(["value1"])
    end

    it "Add 2 attributes." do
      @methodData.add_parameters("value1")
      @methodData.add_parameters("value2")
      attributes = @methodData.parameters
      expect(attributes).to match_array(["value1", "value2"])
    end
  end

  context "When have codiditional statements." do
    it "Simple case of conditional statment" do
      condiditonal = Languages::ConditionalData.new
      condiditonal.type = "IF"
      condiditonal.expression = "x > 3"
      @methodData.add_conditional(condiditonal)
      expect(@methodData.conditionals[0].instance_of?(
              Languages::ConditionalData)).to eq(true)
    end
  end

  context "Copy from FunctionAbstract to MethodData" do
    it "Verify copy" do
      lalala = Languages::FunctionAbstract.new("lalala")
      lalala.comments = "abc"

      condiditonal = Languages::ConditionalData.new
      condiditonal.type = "IF"
      condiditonal.expression = "x > 3"
      lalala.add_conditional(condiditonal)

      @methodData << lalala
      expect(@methodData.name).to eq("lalala")
      expect(@methodData.comments).to eq("abc")
      expect(@methodData.comments).to eq("abc")
      expect(@methodData.conditionals[0].instance_of?(
              Languages::ConditionalData)).to eq(true)
      expect(@methodData.type).to eq("METHOD")
    end
  end

  after :each do
    @methodData = nil
  end

end
