require_relative '../../spec_helper'

RSpec.describe Languages::Ruby::VariableGlobalRuby do

  before :all do
    @variableRuby = Languages::Ruby::VariableGlobalRuby.new
  end

  context "Simple variable (one per line)" do

    it "Capture simple variable." do
      variable = @variableRuby.get_variable("one = 1")
      expect(variable.name).to eq("one")
      expect(variable.value).to eq("1")

      variable = @variableRuby.get_variable("  two = 2")
      expect(variable.name).to eq("two")
      expect(variable.value).to eq("2")

      variable = @variableRuby.get_variable("three = 'three_value'")
      expect(variable.name).to eq("three")
      expect(variable.value).to eq("three_value")

      variable = @variableRuby.get_variable("four = []")
      expect(variable.name).to eq("four")
      expect(variable.value).to eq("[]")
    end

    it "Capture simple variable with one @" do
      variable = @variableRuby.get_variable("@one")
      expect(variable.name).to eq("one")

      variable = @variableRuby.get_variable("@four = 'four_value'")
      expect(variable.name).to eq("four")
      expect(variable.value).to eq("four_value")

      variable = @variableRuby.get_variable("   @five = 5")
      expect(variable.name).to eq("five")
      expect(variable.value).to eq("5")
    end

    it "Capture simple variable with two @@" do
      variable = @variableRuby.get_variable("@@three")
      expect(variable.name).to eq("three")
    end

  end

  RSpec.shared_examples "Compare array" do |lineInput, arrayComp, description|

    it ": #{description}" do
      listResult = []
      capturedList = @variableRuby.get_variable(lineInput)
      capturedList.each do |element|
        listResult.push(element.name)
      end
      expect(listResult).to match_array(@arrayComp)
    end

  end

  context "Complex variable declaration (more then one per line)." do

    it "Multiple simple variable in one line, separated by comma." do
      lineParse = "one = 1, two = 2, three = 'three'"
      arrayCompare = ["one", "two", "three"]
      message = "Check names."
      include_examples "Compare array", lineParse, arrayCompare, message

      lineParse = "     one   =  1,   two=2, three    =     'three'   "
      arrayCompare = ["one", "two", "three"]
      message = "Check names."
      include_examples "Compare array", lineParse, arrayCompare, message
    end

    it "Multiple variable in one line, separated by comma and using @" do
      lineParse = "@one = 1, @two = 2, @three = 'three'"
      arrayCompare = ["one", "two", "three"]
      message = "Check names (with @). Nice code."
      include_examples "Compare array", lineParse, arrayCompare, message

      lineParse = "     @one = 1, @two =2     ,@three   =   'three'"
      arrayCompare = ["one", "two", "three"]
      message = "Check names. Not nice code."
      include_examples "Compare array", lineParse, arrayCompare, message

    end

    it "Multiple declaration with assignment, simple case." do

      lineParse = "one = two = three = 47"
      arrayCompare = ["one", "two", "three"]
      message = "Check names. Nice code."
      include_examples "Compare array", lineParse, arrayCompare, message

      lineParse = "one                  =two     =    three =   47"
      arrayCompare = ["one", "two", "three"]
      message = "Check names. Not nice code."
      include_examples "Compare array", lineParse, arrayCompare, message
 
    end

    it "Multiple declaration with assignment, and with @" do

      lineParse = "@one = @two = @three = 59"
      arrayCompare = ["one", "two", "three"]
      message = "Check names. Nice code."
      include_examples "Compare array", lineParse, arrayCompare, message

      lineParse = "     @one                =   @two =  @three =   89 "
      arrayCompare = ["one", "two", "three"]
      message = "Check names. Not nice code."
      include_examples "Compare array", lineParse, arrayCompare, message
 
    end

  end

  after :all do
    @variableRuby = nil
  end

end
