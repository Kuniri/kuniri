require_relative '../../../spec_helper'

RSpec.describe Languages::FunctionData do

  before :each do
    @functionData = Languages::FunctionData.new("globalFunction")
  end

  context "When function has no parameter" do
    it "Set function name" do
      expect(@functionData.name).to eq("globalFunction")

      @functionData.name = "xpto"
      expect(@functionData.name).to eq("xpto")
    end
  end

  context "When instantiating" do
    it "Does not set name" do
      @functionData = Languages::FunctionData.new(nil)
      expect(@functionData.name).to be_nil
      @functionData = Languages::FunctionData.new(1)
      expect(@functionData.name).to be_nil
    end
  end

  context "Copy from FunctionAbstract to FunctionData" do
    it "Verify copy" do
      lalala = Languages::FunctionAbstract.new("lalala")
      lalala.comments = "abc"

      condiditonal = Languages::ConditionalData.new
      condiditonal.type = Languages::IF_LABEL
      condiditonal.expression = "x > 3"
      lalala.add_conditional(condiditonal)

      @functionData << lalala
      expect(@functionData.name).to eq("lalala")
      expect(@functionData.comments).to eq("abc")
      expect(@functionData.comments).to eq("abc")
      all = @functionData.managerCondLoopAndBlock.basicStructure
      expect(all[0].instance_of?(Languages::ConditionalData)).to eq(true)
      expect(@functionData.type).to eq("GLOBALFUNCTION")
    end
  end

  after :each do
    @functionData = nil
  end

end
