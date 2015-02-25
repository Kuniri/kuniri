require_relative '../../spec_helper'

RSpec.describe Languages::ConstructorData do

  before :all do
    @constructorData = Languages::ConstructorData.new
  end

  context "" do

    it "Constructor name" do
      @constructorData.name = "initialize"
      expect(@constructorData.name).to eq("initialize")
    end

    it "Attributes" do
      attributes = @constructorData.get_attributes
      expect(attributes).to eq([])
    end

  end

  after :all do
    @constructorData = nil
  end

end
