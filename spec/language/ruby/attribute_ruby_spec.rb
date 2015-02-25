require_relative '../../spec_helper'

RSpec.describe Languages::Ruby::AttributeRuby do

  before :all do
    @rubyAttr = Languages::Ruby::AttributeRuby.new
    @singleResult = "value"
    @multiResult = ["value1", "value2", "value3", "value4"]
  end

  context "# Attribute handling" do
    it "Simple attribute with @" do
      captured = @rubyAttr.get_attribute("@value")[0].name
      expect(captured).to eq(@singleResult)

      captured = @rubyAttr.get_attribute("       @value")[0].name
      expect(@rubyAttr.get_attribute(captured).to eq(@singleResult)

      captured = @rubyAttr.get_attribute("    @value  ")[0].name
      expect(@rubyAttr.get_attribute(captured).to eq(@singleResult)
    end

    it "Simple attribute with attr_" do
      captured = @rubyAttr.get_attribute("attr_write :value")[0].name
      expect(captured).to eq(@singleResult)

      captured = @rubyAttr.get_attribute("attr_read :value")[0].name
      expect(captured).to eq(@singleResult)

      captured = @rubyAttr.get_attribute("attr_accessor :value")[0].name
      expect(captured).to eq(@singleResult)

      captured = @rubyAttr.get_attribute("    attr_write :value")[0].name
      expect(captured).to eq(@singleResult)

      captured = @rubyAttr.get_attribute("  attr_write :value")[0].name
      expect(captured).to eq(@singleResult)

      captured = @rubyAttr.get_attribute("  attr_read :value  ")[0].name
      expect(captured).to eq(@result)
    end

    it "Multiple declaration in line with @ and separated by comma" do
      #TODO: DISCOVER HOW TO TEST LIST OF ELEMENTS
      # Spaces in the begin and in the end.
      input = "@value1, @value2, @value3, @value4"
      listResult = []

      capturedList = @rubyAttr.get_attribute(input)
      capturedList.each do |element|
        listResult.append(element.name)
      end 
      expect(capturedList).to eq(@multiResult)

      #TODO: DISCOVER THE CORRECT WAY TO INSERT A FUNCTION
      capturedList = @rubyAttr.get_attribute("     " + input)
      capturedList.each do |element|
        listResult.append(element.name)
      end
      expect(captured).to eq(@multiResult)

      capturedList = @rubyAttr.get_attribute(input + "     ")
      capturedList.each do |element|
        listResult.append(element.name)
      end
      expect(captured).to eq(@multiResult)

      capturedList = @rubyAttr.get_attribute("  " + input + " ")
      capturedList.each do |element|
        listResult.append(element.name)
      end
      expect(captured).to eq(@multiResult)

      # Spaces between comma
      capturedList = @rubyAttr.get_attribute(input.gsub(/,/, ", "))
      capturedList.each do |element|
        listResult.append(element.name)
      end
      expect(listResult).to eq(@multiResult)

      capturedList = @rubyAttr.get_attribute(input.gsub(/,/, " , "))
      capturedList.each do |element|
        listResult.append(element.name)
      end
      expect(capturedList).to eq(@multiResult)

      capturedList = @rubyAttr.get_attribute(input.gsub(/,/, "   ,   "))
      capturedList.each do |element|
        listResult.append(element.name)
      end
      expect(capturedList).to eq(@multiResult)

      # Attributes with assignments
      input = "@value1 = 3, @value2 = 1, @value3, @value=4"
      capturedList = @rubyAttr.get_attribute(input)
      capturedList.each do |element|
        listResult.append(element.name)
      end
      expect(capturedList).to eq(@multiResult)

    end

    it "Multiple declaration in line, separated by equal" do
      input = "@value1 = @value2 = @value3"

      # TODO: DISCOVER HOW TO SHARE TEST, BECAUSE THIS TEST WILL BE SIMILAR TO
      #   TO THE TESTS ABOVE
      listResult = []
      capturedList = @rubyAttr.get_attribute(input)
      capturedList.each do |element|
        listResult.append(element.name)
      end 
      expect(capturedList).to eq(@multiResult)
    end

    it "Attribute assignment" do
    end
  end

  after :all do
    @rubyAttr = nil
  end
end
