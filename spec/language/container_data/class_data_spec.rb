require_relative '../../spec_helper'

RSpec.describe Languages::ClassData do

  before :all do
    @classData = Languages::ClassData.new
    @classData.name = "Xpto"
  end

  context "# Class data container" do

    it "Get/Set class name" do
      expect(@classData.name).to eq("Xpto")

      @classData.name = "Abc"
      expect(@classData.name).to eq("Abc")
    end

    it "Visibility" do
      expect(@classData.visibility).to eq("public")

      @classData.visibility = "private"
      expect(@classData.visibility).to eq("private")
    end

    it "Add attributes" do
      # TODO: COMPARE LIST
      attributes = @classData.get_attributes
      expect(attributes).to eq([])

      # TODO: ATTRIBUTE IS AN ATTRIBUTEDATA, IT MEANS YOU HAVE TO HANDLE IT
      # TODO: YOU HAVE TO ADD ATTRIBUTEDATA!!!
      @classData.add_attribute("attribute1")
      attributes = @classData.get_attributes
      expect(attributes).to eq(["attribute1"])

      @classData.add_attribute("attribute2")
      attributes = @classData.get_attributes
      expect(attributes).to eq(["attributes1", "attribute2"])

      @classData.add_attribute("attribute3")
      attributes = @classData.get_attributes
      expect(attributes).to eq(["attribute1", "attribute2", "attribute3"])
    end

    it "Add methods" do
      methods = @classData.get_methods
      expect(methods).to eq([])

      # TODO: YOU HAVE TO ADD METHODDATA
      @classData.add_method("xpto")
    end

    it "Add constructors" do
    end

  end


  after :all do
    @classData = nil
  end

end
