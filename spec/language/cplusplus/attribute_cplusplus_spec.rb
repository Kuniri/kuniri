require_relative '../../spec_helper'

RSpec.describe Languages::Cplusplus::AttributeCplusplus do

  before :all do
    @cppAttr = Languages::Cplusplus::AttributeCplusplus.new
    @singleResult = "int value"
    @multiResult = ["int value1", "int value2", "int value3", "int value4"]
  end

  context "When is a single attribute" do
    it "Simple case" do
      captured = @cppAttr.get_attribute("int value;")[0]
      expect(captured.name).to eq(@singleResult)
    end

    it "Whitespace before" do
      captured = @cppAttr.get_attribute("       int value;")[0]
      expect(captured.name).to eq(@singleResult)
    end

    it "Between whitespace" do
      captured = @cppAttr.get_attribute("    int   value  ;  ")[0]
      expect(captured.name).to eq(@singleResult)
    end
  end

  RSpec.shared_examples "Multiple declarations" do |input, description|

    it ": #{description}" do
      listResult = []
      capturedList = @cppAttr.get_attribute(input)
      capturedList.each do |element|
        listResult.push(element.name)
      end
      expect(listResult).to match_array(@multiResult)
    end

  end

  context "When multiple declarations with comma" do
    input = "int value1, value2, value3, value4;"
    message = "Use only one space."
    include_examples "Multiple declarations", input, message

    input = "    int value1, value2, value3, value4;"
    message = "Whitespace in the beginning."
    include_examples "Multiple declarations", input, message

    input = "int value1, value2, value3, value4;    "
    message = "Whitespace in the end."
    include_examples "Multiple declarations", input, message

    input = "   int value1   ,   value2  ,   value3,  value4;    "
    message = "Whitespace before and after comma."
    include_examples "Multiple declarations", input, message

    input = "int value1, value2 = 2, value3 = 10, value4;"
    message = "Assignment."
    include_examples "Multiple declarations", input, message

    input = "int value1,  value2 = 2   , value3 =    10,    value4;  "
    message = "Whitespace Assignment."
    include_examples "Multiple declarations", input, message
 end

  after :all do
    @cppAttr = nil
  end

end