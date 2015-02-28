require_relative '../../spec_helper'

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
      @constructorData.add_attribute("value1")
      attributes = @constructorData.get_attributes
      expect(attributes).to match_array(["value1"])
    end

    it "Add 2 attributes." do
      @constructorData.add_attribute("value1")
      @constructorData.add_attribute("value2")
      attributes = @constructorData.get_attributes
      expect(attributes).to match_array(["value1", "value2"])
    end
  end

  after :each do
    @constructorData = nil
  end

end
