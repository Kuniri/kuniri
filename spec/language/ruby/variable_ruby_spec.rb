require_relative '../../spec_helper'

RSpec.describe Languages::Ruby::VariableGlobalRuby do

  before :all do
    @variableRuby = Languages::Ruby::VariableGlobalRuby.new
  end

  context "Simple variable (one per line)" do

    it "Capture simple variable." do
      variable = @variableRuby.get_variable("one = 1")
      expect(variable[0].name).to eq("one")
      expect(variable[0].value).to eq("1")

      variable = @variableRuby.get_variable("  two = 2")
      expect(variable[0].name).to eq("two")
      expect(variable[0].value).to eq("2")

      variable = @variableRuby.get_variable("three = 'three_value'")
      expect(variable[0].name).to eq("three")
      expect(variable[0].value).to eq("three_value")

      variable = @variableRuby.get_variable("four = []")
      expect(variable[0].name).to eq("four")
      expect(variable[0].value).to eq("[]")
    end

    it "Capture simple variable with one @" do
      variable = @variableRuby.get_variable("@one")
      expect(variable[0].name).to eq("one")

      variable = @variableRuby.get_variable("@four = 'four_value'")
      expect(variable[0].name).to eq("four")
      expect(variable[0].value).to eq("four_value")

      variable = @variableRuby.get_variable("   @five = 5")
      expect(variable[0].name).to eq("five")
      expect(variable[0].value).to eq("5")
    end

    it "Capture simple variable with two @@" do
      variable = @variableRuby.get_variable("@@three")
      expect(variable[0].name).to eq("three")
    end

  end

  context "Verify value assignment to simple global variable." do
    it "Simple case: without @, @@ or $" do
      variable = @variableRuby.get_variable('yesImVerySimpe = 12')
      expect(variable[0].value).to eq('12')

      variable = @variableRuby.get_variable('     yesImVerySimpe = 12')
      expect(variable[0].value).to eq('12')

      variable = @variableRuby.get_variable('   yesImVerySimpe = 12   ')
      expect(variable[0].value).to eq('12')

      variable = @variableRuby.get_variable('yesImVerySimpe   = 12')
      expect(variable[0].value).to eq('12')

      variable = @variableRuby.get_variable('yesImVerySimpe   =   12')
      expect(variable[0].value).to eq('12')

      variable = @variableRuby.get_variable('   yesImVerySimpe   =   12   ')
      expect(variable[0].value).to eq('12')

      variable = @variableRuby.get_variable('   yesImVerySimpe   =   "yes"   ')
      expect(variable[0].value).to eq('yes')
    end

    it "Value after variable with @" do
      variable = @variableRuby.get_variable('@yesImVerySimpe = 12')
      expect(variable[0].value).to eq('12')

      variable = @variableRuby.get_variable('     @yesImVerySimpe = 12')
      expect(variable[0].value).to eq('12')

      variable = @variableRuby.get_variable('   @yesImVerySimpe = 12   ')
      expect(variable[0].value).to eq('12')

      variable = @variableRuby.get_variable('@yesImVerySimpe   = 12')
      expect(variable[0].value).to eq('12')

      variable = @variableRuby.get_variable('@yesImVerySimpe   =   12')
      expect(variable[0].value).to eq('12')

      variable = @variableRuby.get_variable('   @yesImVerySimpe   =   12   ')
      expect(variable[0].value).to eq('12')

      variable = @variableRuby.get_variable(' @yesImVerySimpe  =   "yes"   ')
      expect(variable[0].value).to eq('yes')
    end

    it "Value after variable with @@" do
      variable = @variableRuby.get_variable('@@yesImVerySimpe = 12')
      expect(variable[0].value).to eq('12')

      variable = @variableRuby.get_variable('     @@yesImVerySimpe = 12')
      expect(variable[0].value).to eq('12')

      variable = @variableRuby.get_variable('   @@yesImVerySimpe = 12   ')
      expect(variable[0].value).to eq('12')

      variable = @variableRuby.get_variable('@@yesImVerySimpe   = 12')
      expect(variable[0].value).to eq('12')

      variable = @variableRuby.get_variable('@@yesImVerySimpe   =   12')
      expect(variable[0].value).to eq('12')

      variable = @variableRuby.get_variable('   @@yesImVerySimpe   =   12   ')
      expect(variable[0].value).to eq('12')

      variable = @variableRuby.get_variable('  @@yesImVerySimpe   =  "yes" ')
      expect(variable[0].value).to eq('yes')
    end

    it "Value after variable with $" do
      variable = @variableRuby.get_variable('$yesImVerySimpe = 12')
      expect(variable[0].value).to eq('12')

      variable = @variableRuby.get_variable('     $yesImVerySimpe = 12')
      expect(variable[0].value).to eq('12')

      variable = @variableRuby.get_variable('   $yesImVerySimpe = 12   ')
      expect(variable[0].value).to eq('12')

      variable = @variableRuby.get_variable('$yesImVerySimpe   = 12')
      expect(variable[0].value).to eq('12')

      variable = @variableRuby.get_variable('$yesImVerySimpe   =   12')
      expect(variable[0].value).to eq('12')

      variable = @variableRuby.get_variable('   $yesImVerySimpe   =   12   ')
      expect(variable[0].value).to eq('12')

      variable = @variableRuby.get_variable(' $yesImVerySimpe   =  "yes" ')
      expect(variable[0].value).to eq('yes')
    end
  end

  context "Special case" do

    it "Ruby multiple line comment - =begin" do
      variable = @variableRuby.get_variable("=begin")
      expect(variable).to eq(nil)
    end

  end

  RSpec.shared_examples "Compare array" do |lineInput, arrayComp, description|

    it ": #{description}" do
      listResult = []
      capturedList = @variableRuby.get_variable(lineInput)
      capturedList.each do |element|
        listResult.push(element.name)
      end
      expect(listResult).to match_array(arrayComp)
    end
  end

  context "Complex variable declaration (more then one per line)." do
    lineParse = "one = 1, two = 2, three = 'three'"
    arrayCompare = ["one", "two", "three"]
    message = " -> Multiple variable in line WITH = and WITHOUT @."
    include_examples "Compare array", lineParse, arrayCompare, message

    lineParse = "     one   =  1,   two=2, three    =     'three'   "
    arrayCompare = ["one", "two", "three"]
    message = " -> Multiple variable in line WITH = and WITHOUT @. (Not nice)"
    include_examples "Compare array", lineParse, arrayCompare, message

    lineParse = "@one, @two, @three"
    arrayCompare = ["one", "two", "three"]
    message = " -> Multiple variable in line ONLY WITH , and @."
    include_examples "Compare array", lineParse, arrayCompare, message

    lineParse = "       @one    , @two     ,       @three  "
    arrayCompare = ["one", "two", "three"]
    message = " -> Multiple variable in line ONLY WITH , and @. (Not nice)"
    include_examples "Compare array", lineParse, arrayCompare, message

    lineParse = "@one = 1, @two = 2, @three = 'three'"
    arrayCompare = ["one", "two", "three"]
    message = " -> Multiple variable in line WITH = and @."
    include_examples "Compare array", lineParse, arrayCompare, message

    lineParse = "     @one = 1, @two =2     ,@three   =   'three'"
    arrayCompare = ["one", "two", "three"]
    message = " -> Multiple variable in line WITH = and @. (Not nice)"
    include_examples "Compare array", lineParse, arrayCompare, message

    lineParse = " @one, @two = 3,@three "
    arrayCompare = ["one", "two", "three"]
    message = " -> Multiple variable in line WITH = and @. (Mixed)"
    include_examples "Compare array", lineParse, arrayCompare, message

    #it "Multiple declaration with assignment, simple case." do
    lineParse = "one = two = three = 47"
    arrayCompare = ["one", "two", "three"]
    message = " -> Multiple variable ONLY WITH ="
    include_examples "Compare array", lineParse, arrayCompare, message

    lineParse = "one                  =two     =    three =   47"
    arrayCompare = ["one", "two", "three"]
    message = " -> Multiple variable ONLY WITH =. (Not nice)"
    include_examples "Compare array", lineParse, arrayCompare, message
    #end

    lineParse = "@one = @two = @three = 59"
    arrayCompare = ["one", "two", "three"]
    message = " -> Multiple variable WITH = and @"
    include_examples "Compare array", lineParse, arrayCompare, message

    lineParse = "     @one                =   @two =  @three =   89 "
    arrayCompare = ["one", "two", "three"]
    message = " -> Multiple variable WITH = and @. (Not nice)"
    include_examples "Compare array", lineParse, arrayCompare, message

  end

  after :all do
    @variableRuby = nil
  end

end
