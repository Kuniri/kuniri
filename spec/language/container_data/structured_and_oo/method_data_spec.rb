require_relative '../../../spec_helper'

RSpec.describe Languages::MethodData do

  before :all do
    @methodData = Languages::MethodData.new("Simple")
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

  after :all do
    @methodData = nil
  end

end
