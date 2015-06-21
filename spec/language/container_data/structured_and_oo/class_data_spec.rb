require_relative '../../../spec_helper'

RSpec.describe Languages::ClassData do

  before :each do
    @classData = Languages::ClassData.new
    @classData.name = "Xpto"
  end

  context "When set and get class name" do

    it "Get class name." do
      expect(@classData.name).to eq("Xpto")
    end

    it "Set class name." do
      @classData.name = "Abc"
      expect(@classData.name).to eq("Abc")
    end

    it "Visibility." do
      expect(@classData.visibility).to eq("public")

      @classData.visibility = "private"
      expect(@classData.visibility).to eq("private")
    end
  end

  RSpec.shared_examples "Add attribute" do |attributes, description|

    it ": #{description}" do

      listOfAttributes = []

      attributes.each do |nameElement|
        listOfAttributes.push(Languages::AttributeData.new(nameElement))
      end
 
      @classData.add_attribute(listOfAttributes)

      attributeList = @classData.attributes
      listResult = []

      attributeList.each do |element|
        listResult.push(element.name)
      end

      expect(listResult).to match_array(attributes)
    end

  end

  context "When add attribute" do
    it "No attribute." do
      attributes = @classData.get_attributes
      expect(attributes).to eq([])
    end

    message = "Add 1 element."
    include_examples "Add attribute", ["value1"], message

    message = "Add 2 element."
    include_examples "Add attribute", ["value1", "value2"], message

    message = "Add 3 element."
    include_examples "Add attribute", ["value1", "value2", "value3"], message
  end

  RSpec.shared_examples "Add method" do |methods, description|

    it ": #{description}" do

      methods.each do |element|
        method = Languages::FunctionData.new(element)
        @classData.add_method(method)
      end

      methodList = @classData.get_methods
      listResult = []
      methodList.each do |element|
        listResult.push(element.name)
      end
      expect(listResult).to match_array(methods)
    end

  end


  context "When add method" do
    it "No method" do
      methods = @classData.get_methods
      expect(methods).to eq([])
    end

    message = "Add 1 method."
    include_examples "Add method", ["method1"], message

    message = "Add 2 method"
    include_examples "Add method", ["method1", "method2"], message
  end

  context "When add constructor" do
    it "Add constructors" do
      constructorAdd = Languages::ConstructorData.new("constructor")
      @classData.add_constructor(constructorAdd)
      constructors = @classData.get_constructors
      expect(constructors[0].name == "constructor").to be true
    end

    it "Try to add non-constructor" do
      @classData.add_constructor("xpto")
        expect(@classData.get_constructors).to match_array([])
    end

  end

  after :each do
    @classData = nil
  end

end
