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

  after :all do
    @functionData = nil
  end

end
