require_relative '../../../spec_helper'

RSpec.describe Languages::FunctionData do

  before :all do
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

  after :all do
    @functionData = nil
  end

end
