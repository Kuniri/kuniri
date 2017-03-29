require_relative '../../../spec_helper'

RSpec.describe Languages::ConstructorData do

  before :each do
    @constructorData = Languages::ConstructorData.new("initialize")
  end

  context "When constructor without parameters" do
    it "Constructor name" do
      @constructorData.name = "initialize"
      expect(@constructorData.name).to eq("initialize")
    end
  end

  context "When constructor has parameter" do
    it "Add 1 attributes." do
      @constructorData.add_parameters("value1")
      attributes = @constructorData.parameters
      expect(attributes).to match_array(["value1"])
    end

    it "Add 2 attributes." do
      @constructorData.add_parameters("value1")
      @constructorData.add_parameters("value2")
      attributes = @constructorData.parameters
      expect(attributes).to match_array(["value1", "value2"])
    end
  end

  context "When have codiditional statements." do
    it "Simple case of conditional statment" do
      condiditonal = Languages::ConditionalData.new
      condiditonal.type = "IF"
      condiditonal.expression = "x > 3"
      @constructorData.add_conditional(condiditonal)
      all = @constructorData.managerCondLoopAndBlock.basicStructure
      expect(all[0].instance_of?(Languages::ConditionalData)).to eq(true)
    end
  end

  context "When instantiating" do
    it "Does not set name" do
      @constructorData = Languages::ConstructorData.new(nil)
      expect(@constructorData.name).to be_nil
      @constructorData = Languages::ConstructorData.new(1)
      expect(@constructorData.name).to be_nil
    end
  end

  context "Copy from FunctionAbstract to constructor" do
    it "Simple copy" do
      lalala = Languages::FunctionAbstract.new("lalala")
      lalala.comments = "abc"

      condiditonal = Languages::ConditionalData.new
      condiditonal.type = "IF"
      condiditonal.expression = "x > 3"
      lalala.add_conditional(condiditonal)

      @constructorData << lalala
      expect(@constructorData.name).to eq("lalala")
      expect(@constructorData.comments).to eq("abc")
      expect(@constructorData.comments).to eq("abc")
      all = @constructorData.managerCondLoopAndBlock.basicStructure
      expect(all[0].instance_of?(Languages::ConditionalData)).to eq(true)
      expect(@constructorData.type).to eq("CONSTRUCTOR")
    end

  end

  after :each do
    @constructorData = nil
  end

end
