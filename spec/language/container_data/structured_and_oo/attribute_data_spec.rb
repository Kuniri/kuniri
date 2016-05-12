require_relative '../../../spec_helper'

RSpec.describe Languages::AttributeData do

  before :all do
    @attributeData = Languages::AttributeData.new("xpto")
  end

  context "# Attribute data" do
    it "Get name" do
      expect(@attributeData.name).to eq("xpto")

      @attributeData.name = "banana"
      expect(@attributeData.name).to eq("banana")
    end

    it "Get visibility" do
      expect(@attributeData.visibility).to eq("public")

      @attributeData.visibility = "private"
      expect(@attributeData.visibility).to eq("private")

      @attributeData.visibility = "protected"
      expect(@attributeData.visibility).to eq("protected")
    end

    it "Does not set name" do
      @attributeData = Languages::AttributeData.new(nil)
      expect(@attributeData.name).to eq('fakeName')
      @attributeData = Languages::AttributeData.new(1)
      expect(@attributeData.name).to eq('fakeName')
    end
  end

  after :all do
    @attributeData = nil
  end

end
