require_relative '../../spec_helper'

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

      attributes.each do |element|
        attribute = Languages::AttributeData.new(element)
        @classData.add_attribute(attribute)
      end

      attributeList = @classData.get_attributes
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
        method = Languages::MethodData.new(element)
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

#  context "When add constructor" do
#    it "Add constructors" do
#    end
#  end

  after :each do
    @classData = nil
  end

end
