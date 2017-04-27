require_relative '../../spec_helper'

RSpec.describe Languages::Ruby::FunctionBehaviorRuby do

  before :all do
    @functionBehaviorRuby = Languages::Ruby::FunctionBehaviorRuby.new
  end

  context "When method without parameters" do
    it "Common declaration." do
      input = "def xpto_method"
      expect(@functionBehaviorRuby.get_function(input).name)
              .to eq("xpto_method")
    end

    it "With whitespace in the beginning." do
      input = "   def xpto_method"
      expect(@functionBehaviorRuby.get_function(input).name)
              .to eq("xpto_method")
    end

    it "With whitespace at the end." do
      input = "def xpto_method "
      expect(@functionBehaviorRuby.get_function(input).name)
              .to eq("xpto_method")
    end

    it "Between whitespace." do
      input = "   def xpto_method "
      expect(@functionBehaviorRuby.get_function(input).name)
              .to eq("xpto_method")
    end

    it "Whitespace between def and method name." do
      input = "def  xpto_method"
      expect(@functionBehaviorRuby.get_function(input).name)
              .to eq("xpto_method")
    end

    it "Whitespace in the beginning and between def." do
      input = "  def   xpto_method"
      expect(@functionBehaviorRuby.get_function(input).name)
              .to eq("xpto_method")
    end

    it "Whitespace between def and in the end." do
      input = "def  xpto_method    "
      expect(@functionBehaviorRuby.get_function(input).name)
              .to eq("xpto_method")
    end

    it "Tab in the beginning and space in the end." do
      input = "     def  xpto_method "
      expect(@functionBehaviorRuby.get_function(input).name)
              .to eq("xpto_method")
    end

    it "Whitespace in the beginning and in the end." do
      input = "       def  xpto_method    "
      expect(@functionBehaviorRuby.get_function(input).name)
              .to eq("xpto_method")
    end

    it "Many whitespace between def." do
      input = "     def        xpto_method"
      expect(@functionBehaviorRuby.get_function(input).name)
              .to eq("xpto_method")
    end

    it "Whitespace in the beginning, between and in the end" do
      input = "  def   xpto_method   "
      expect(@functionBehaviorRuby.get_function(input).name)
              .to eq("xpto_method")
    end

    it "get righ parameters without parenthesis" do
      input = "     def method\n"
      expect(@functionBehaviorRuby.get_function(input).parameters)
              .to match_array([])
    end
    it "get righ parameters without parenthesis and with spaces in the end" do
      input = "     def method    \n"
      expect(@functionBehaviorRuby.get_function(input).parameters)
              .to match_array([])
    end
    it "get righ parameters with parenthesis" do
      input = "     def method()\n"
      expect(@functionBehaviorRuby.get_function(input).parameters)
              .to match_array([])
    end
    it "get righ parameters with parenthesis and spaces in the end" do
      input = "     def method()    \n"
      expect(@functionBehaviorRuby.get_function(input).parameters)
              .to match_array([])
    end
    it "get righ parameters with parenthesis and space after method name" do
      input = "     def method ()\n"
      expect(@functionBehaviorRuby.get_function(input).parameters)
              .to match_array([])
    end
    it "get righ parameters with parenthesis and spaces in the end and space after method name" do
      input = "     def method ()    \n"
      expect(@functionBehaviorRuby.get_function(input).parameters)
              .to match_array([])
    end
  end

  context "With parameters" do
    it "Take method name" do
      input = "def xpto_method(a, b, c, d)\n"
      expect(@functionBehaviorRuby.get_function(input).name)
              .to eq("xpto_method")
    end

    it "Whitespace in the beginning." do
      input = "    def xpto_method(a, b, c, d)\n"
      expect(@functionBehaviorRuby.get_function(input).name)
              .to eq("xpto_method")
    end

    it "Whitespace in the end." do
      input = "def xpto_method(a, b, c, d)     \n"
      expect(@functionBehaviorRuby.get_function(input).name)
              .to eq("xpto_method")
    end

    it "Between whitespace." do
      input = "    def xpto_method(a, b, c, d)   \n"
      expect(@functionBehaviorRuby.get_function(input).name)
              .to eq("xpto_method")
    end

    it "Spaces between parameters." do
      input = "def xpto_method (a, b, c, d)\n"
      expect(@functionBehaviorRuby.get_function(input).name)
              .to eq("xpto_method")
    end

    it "Many whitespace between method name and parameters." do
      input = "  def xpto_method      (a, b, c, d)\n"
      expect(@functionBehaviorRuby.get_function(input).name)
              .to eq("xpto_method")
    end

    it "Many whitespace between method declaration." do
      input = "   def    xpto_method     (   a  , b  ,      c   ,     d   ) \n"
      expect(@functionBehaviorRuby.get_function(input).name)
              .to eq("xpto_method")
    end

    it "Different whitespace patterns." do
      input = "  def    xpto_method    (        a, b,    c, d )   \n"
      expect(@functionBehaviorRuby.get_function(input).name)
              .to eq("xpto_method")
    end


  end

  context "When has parameters and parenthesis." do
    it "One parameter" do
      input = "def xpto_method(a)"

      methodOne = @functionBehaviorRuby.get_function(input)
      expect(methodOne.parameters).to match_array(["a"])
    end

    it "Two parameters" do
      input = "def xpto_method(a, b)"

      methodOne = @functionBehaviorRuby.get_function(input)
      expect(methodOne.parameters).to match_array(["a", "b"])
    end

    it "Three parameters" do
      input = "def xpto_method(a, ab, abc)"

      methodOne = @functionBehaviorRuby.get_function(input)
      expect(methodOne.parameters).to match_array(["a", "ab", "abc"])
    end

    it "Three parameters, with whitespace." do
      input = "def xpto_method (a, ab , abc)   "

      methodOne = @functionBehaviorRuby.get_function(input)
      expect(methodOne.parameters).to match_array(["a", "ab", "abc"])
    end


    it "One parameter with assignment" do
      input = "def xpto_method(a=3)"

      methodOne = @functionBehaviorRuby.get_function(input)
      expect(methodOne.parameters).to match_array([{"a"=>"3"}])
    end

    it "Two parameters with assignment" do
      input = "def xpto_method(a=4, b=7)"

      methodOne = @functionBehaviorRuby.get_function(input)
      expect(methodOne.parameters).to match_array([{"a"=>"4"}, {"b"=>"7"}])
    end

    it "Parameters with whitespace between them." do
      input = "def xpto_method(a=7,               b=8, c =      0, d = 324)"

      methodOne = @functionBehaviorRuby.get_function(input)
      expect(methodOne.parameters).to match_array([{"a"=>"7"}, {"b"=>"8"}, 
                                                  {"c"=>"0"}, {"d"=>"324"}])
    end

    it "Parameters with whitespace between assignment." do
      input = "def xpto_method(a        =  7,b =8, c  =  0,d    = 324)"

      methodOne = @functionBehaviorRuby.get_function(input)
      expect(methodOne.parameters).to match_array([{"a"=>"7"}, {"b"=>"8"}, 
                                                  {"c"=>"0"}, {"d"=>"324"}])

    end

    it "No parameter, just parenthesis" do
      input = "def xpto_method()"

      methodOne = @functionBehaviorRuby.get_function(input)
      expect(methodOne.parameters).to eq([])
    end
  end

  context "When has parameters and no parenthesis." do
    it "No parenthesis, and one parameter" do
      input = "def xpto_method x"
      methodOne = @functionBehaviorRuby.get_function(input)
      expect(methodOne.parameters).to match_array(["x"])
    end

    it "One parameter, with space at the end." do
      input = "def xpto_method x       "
      methodOne = @functionBehaviorRuby.get_function(input)
      expect(methodOne.parameters).to match_array(["x"])
    end

    it "One parameter, with space in the end and in the begining." do
      input = "def xpto_method       x           "
      methodOne = @functionBehaviorRuby.get_function(input)
      expect(methodOne.parameters).to match_array(["x"])
    end

    it "One parameter, multiple spaces" do
      input = "       def xpto_method       x         "
      methodOne = @functionBehaviorRuby.get_function(input)
      expect(methodOne.parameters).to match_array(["x"])
    end

    it "Two parameters" do
      input = "def xpto_method x,y"
      methodOne = @functionBehaviorRuby.get_function(input)
      expect(methodOne.parameters).to match_array(["x", "y"])
    end

    it "Three parameters" do
      input = "def xpto_method x, abcde, xyz"
      methodOne = @functionBehaviorRuby.get_function(input)
      expect(methodOne.parameters).to match_array(["x", "abcde", "xyz"])
    end

    it "Multiple parameters with many spaces" do
      input = " def xpto_method     x ,    m,    nda ,       t  "
      methodOne = @functionBehaviorRuby.get_function(input)
      expect(methodOne.parameters).to match_array(["x", "m", "nda", "t"])
    end

    it "No parenthesis, and one parameter with assignment" do
      input = "def xpto_method x=1"
      methodOne = @functionBehaviorRuby.get_function(input)
      expect(methodOne.parameters).to match_array([{"x"=>"1"}])
    end

    it "One parameter with assignment, with space at the end." do
      input = "def xpto_method x=1       "
      methodOne = @functionBehaviorRuby.get_function(input)
      expect(methodOne.parameters).to match_array([{"x"=>"1"}])
    end

    it "One parameter with: assignment, and spaces as a delimiter." do
      input = "def xpto_method       x=1           "
      methodOne = @functionBehaviorRuby.get_function(input)
      expect(methodOne.parameters).to match_array([{"x"=>"1"}])
    end

    it "One parameter with assignment, multiple spaces" do
      input = "       def xpto_method       x=1         "
      methodOne = @functionBehaviorRuby.get_function(input)
      expect(methodOne.parameters).to match_array([{"x"=>"1"}])
    end

    it "One parameter with assignment with multiple spaces between" do
      input = "def xpto_method       x   =   1           "
      methodOne = @functionBehaviorRuby.get_function(input)
      expect(methodOne.parameters).to match_array([{"x"=>"1"}])
    end

    it "Two parameters with assignment" do
      input = "def xpto_method x=1,y=2"
      methodOne = @functionBehaviorRuby.get_function(input)
      expect(methodOne.parameters).to match_array([{"x"=>"1"},
                                                   {"y"=>"2"}])
    end

    it "Three parameters with assignment" do
      input = "def xpto_method x=1, abcde=2, xyz=3"
      methodOne = @functionBehaviorRuby.get_function(input)
      expect(methodOne.parameters).to match_array([{"x"=>"1"},
                                                   {"abcde"=>"2"},
                                                   {"xyz"=>"3"}])
    end

    it "Multiple parameters with assignment and with many spaces" do
      input = " def xpto_method     x=1 ,    m=65,    nda=8 ,       t=4  "
      methodOne = @functionBehaviorRuby.get_function(input)
      expect(methodOne.parameters).to match_array([{"x"=>"1"},
                                                   {"m"=>"65"}, 
                                                   {"nda"=>"8"},
                                                   {"t"=>"4"}])
    end
  end

  context "Helper methods" do
    it "Split strings by comma" do
      stringList = @functionBehaviorRuby.send(:split_string_by_comma, "a,b")
      expect(stringList).to match_array(["a", "b"])
    end

    it "Split strings without comma" do
      stringList = @functionBehaviorRuby.send(:split_string_by_comma, "ab")
      expect(stringList).to match_array(["ab"])
    end

    it "Gets arguments from function line" do
      input = "    def method a, b, c"
      reg = /def\s+\w+[\s]+(.+)/
      args = @functionBehaviorRuby.send(:get_parameters, input, reg)
      expect(args).to match("a,b,c")
    end

    it "Return array with arguments of line" do
      input = "    def method a, b, c"
      stringList = @functionBehaviorRuby.send(:handling_parameter, input)
      expect(stringList).to match_array(["a", "b", "c"])
    end

    it "Return array with arguments within parenthesis of line" do
      input = "    def method(a, b, c)"
      stringList = @functionBehaviorRuby.send(:handling_parameter, input)
      expect(stringList).to match_array(["a", "b", "c"])
    end

    it "Remove spaces and parenthesis" do
      input = "  (a, b, c)  "
      expect(@functionBehaviorRuby.send(:remove_unnecessary_information, input))
        .to match("a,b,c")
    end

    it "Handles default arguments" do
      input = "a=1,b=2"
      parameterList = @functionBehaviorRuby.send(:handling_default_parameter, input)
      expect(parameterList).to match_array([{"a" => "1"}, {"b" => "2"}])
    end

    it "Handles single default argument" do
      input = "a=1"
      parameterList = @functionBehaviorRuby.send(:handling_default_parameter, input)
      expect(parameterList).to match_array([{"a" => "1"}])
    end

    it "Gets name of function" do
      input = "def method a, b, c"
      fName = @functionBehaviorRuby.send(:detect_function, input)
      expect(fName).to match("method")
    end

  end

  after :all do
    @functionBehaviorRuby = nil
  end

end
