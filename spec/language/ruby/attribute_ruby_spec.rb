require_relative '../../spec_helper'

RSpec.describe Languages::Ruby::AttributeRuby do

  before :all do
    @rubyAttr = Languages::Ruby::AttributeRuby.new
    @singleResult = "value"
    @multiResult = ["value1", "value2", "value3", "value4"]
  end

  context "When is a single attribute with @" do
    it "Simple case with @" do
      captured = @rubyAttr.get_attribute("@value")[0]
      expect(captured.name).to eq(@singleResult)
    end

    it "Whitespace before" do
      captured = @rubyAttr.get_attribute("       @value")[0]
      expect(captured.name).to eq(@singleResult)
    end

    it "Between whitespace" do
      captured = @rubyAttr.get_attribute("    @value  ")[0]
      expect(captured.name).to eq(@singleResult)
    end
  end

  context "When is a single attribute with attr_e" do
    it "With attr_write" do
      captured = @rubyAttr.get_attribute("attr_write :value")[0]
      expect(captured.name).to eq(@singleResult)
    end

    it "With attr_read" do
      captured = @rubyAttr.get_attribute("attr_read :value")[0]
      expect(captured.name).to eq(@singleResult)
    end

    it "With attr_accessor" do
      captured = @rubyAttr.get_attribute("attr_accessor :value")[0]
      expect(captured.name).to eq(@singleResult)
    end

    it "With whitespace before attr_write" do
      captured = @rubyAttr.get_attribute("    attr_write :value")[0]
      expect(captured.name).to eq(@singleResult)
    end

    it "With whitespace before attr_write" do
      captured = @rubyAttr.get_attribute("  attr_write :value")[0]
      expect(captured.name).to eq(@singleResult)
    end

    it "With whitespace before and after attr_read" do
      captured = @rubyAttr.get_attribute("  attr_read :value  ")[0]
      expect(captured.name).to eq(@singleResult)
    end
  end

  RSpec.shared_examples "Multiple declaration" do |input, description|

    it ": #{description}" do
      listResult = []
      capturedList = @rubyAttr.get_attribute(input)
      capturedList.each do |element|
        listResult.push(element.name)
      end
      expect(listResult).to match_array(@multiResult)
    end

  end

  context "When multiple declarations with comma" do
    input = "@value1, @value2, @value3, @value4"
    message = "Use only one space."
    include_examples "Multiple declaration", input, message

    message = "Whitespace in the beginning."
    include_examples "Multiple declaration", "     " + input, message

    message = "Whitespace in the end."
    include_examples "Multiple declaration", input + "     ", message

    message = "Whitespace in the beginning and in the end."
    include_examples "Multiple declaration", "  " + input + " ", message

    message = "White space after comma."
    include_examples "Multiple declaration", input.gsub(/,/, ", "), message

    message = "Whitespace before and after comma."
    include_examples "Multiple declaration", input.gsub(/,/, " , "), message

    message = "Many whitespace before and after comma."
    include_examples "Multiple declaration", input.gsub(/,/, "   ,   "), message

    input = "@value1 = 3, @value2 = 1, @value3 = 324, @value4=28"
    message = "Assignment."
    include_examples "Multiple declaration", input, message

    input = "@value1 = 3, @value2 = 1, @value3, @value4=28"
    message = "Partial Assignment."
    include_examples "Multiple declaration", input, message
 end

  context "# Multiple declaration (equal)" do
    input = "@value1 = @value2 = @value3 = @value4"
    message = "Separated by equal."
    include_examples "Multiple declaration", input, message

    message = "Whitespace in the beginning."
    include_examples "Multiple declaration", "      " + input, message

    message = "Whitespace in the end."
    include_examples "Multiple declaration", input + "          "

    message = "Whitespace in before and after the input."
    include_examples "Multiple declaration", "       " + input + "   ", message

    message = "Whitespace between equal."
    include_examples "Multiple declaration", input.gsub(/=/, "   =  "), message
  end

  after :all do
    @rubyAttr = nil
  end
end
