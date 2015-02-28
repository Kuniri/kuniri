require_relative '../../spec_helper'

RSpec.describe Languages::Ruby::MethodRuby do

  before :all do
    @methodRuby = Languages::Ruby::MethodRuby.new
  end

  context "When method without parameters" do
    it "Common declaration." do
      input = "def xpto_method"
      expect(@methodRuby.get_method(input).name).to eq("xpto_method")
    end

    it "With whitespace in the beginning." do
      input = "   def xpto_method"
      expect(@methodRuby.get_method(input).name).to eq("xpto_method")
    end

    it "With whitespace in the end." do
      input = "def xpto_method "
      expect(@methodRuby.get_method(input).name).to eq("xpto_method")
    end

    it "Between whitespace." do
      input = "   def xpto_method "
      expect(@methodRuby.get_method(input).name).to eq("xpto_method")
    end

    it "Whitespace between def and method name." do
      input = "def  xpto_method"
      expect(@methodRuby.get_method(input).name).to eq("xpto_method")
    end

    it "Whitespace in the beginning and between def." do
      input = "  def   xpto_method"
      expect(@methodRuby.get_method(input).name).to eq("xpto_method")
    end

    it "Whitespace between def and in the end." do
      input = "def  xpto_method    "
      expect(@methodRuby.get_method(input).name).to eq("xpto_method")
    end

    it "Tab in the beginning and space in the end." do
      input = "     def  xpto_method "
      expect(@methodRuby.get_method(input).name).to eq("xpto_method")
    end

    it "Whitespace in the beginning and in the end." do
      input = "       def  xpto_method    "
      expect(@methodRuby.get_method(input).name).to eq("xpto_method")
    end

    it "Many whitespace between def." do
      input = "     def        xpto_method"
      expect(@methodRuby.get_method(input).name).to eq("xpto_method")
    end

    it "Whitespace in the beginning, between and in the end" do  
      input = "  def   xpto_method   "
      expect(@methodRuby.get_method(input).name).to eq("xpto_method")
    end
  end

  context "With parameters" do
    it "Take method name" do
      input = "def xpto_method(a, b, c, d)\n"
      expect(@methodRuby.get_method(input).name).to eq("xpto_method")
    end

    it "Whitespace in the beginning." do
      input = "    def xpto_method(a, b, c, d)\n"
      expect(@methodRuby.get_method(input).name).to eq("xpto_method")
    end

    it "Whitespace in the end." do
      input = "def xpto_method(a, b, c, d)     \n"
      expect(@methodRuby.get_method(input).name).to eq("xpto_method")
    end

    it "Between whitespace." do
      input = "    def xpto_method(a, b, c, d)   \n"
      expect(@methodRuby.get_method(input).name).to eq("xpto_method")
    end

    it "Spaces between parameters." do
      input = "def xpto_method (a, b, c, d)\n"
      expect(@methodRuby.get_method(input).name).to eq("xpto_method")
    end

    it "Many whitespace between method name and parameters." do
      input = "  def xpto_method      (a, b, c, d)\n"
      expect(@methodRuby.get_method(input).name).to eq("xpto_method")
    end

    it "Many whitespace between method declaration." do
      input = "   def    xpto_method     (   a  , b  ,      c   ,     d   ) \n"
      expect(@methodRuby.get_method(input).name).to eq("xpto_method")
    end

    it "Different whitespace patterns." do
      input = "  def    xpto_method    (        a, b,    c, d )   \n"
      expect(@methodRuby.get_method(input).name).to eq("xpto_method")
    end
  end

  context "When has parameters and parenthesis." do
    it "One parameter" do
      input = "def xpto_method(a)"

      methodOne = @methodRuby.get_method(input)
      expect(methodOne.parameters).to match_array(["a"])
    end

    it "Two parameters" do
      input = "def xpto_method(a, b)"

      methodOne = @methodRuby.get_method(input)
      expect(methodOne.parameters).to match_array(["a", "b"])
    end

    it "Three parameters" do
      input = "def xpto_method(a, ab, abc)"

      methodOne = @methodRuby.get_method(input)
      expect(methodOne.parameters).to match_array(["a", "ab", "abc"])
    end

    it "One parameter with assignment" do
      input = "def xpto_method(a=3)"

      methodOne = @methodRuby.get_method(input)
      expect(methodOne.parameters).to match_array([{"a"=>"3"}])
    end

    it "Two parameters with assignment" do
      input = "def xpto_method(a=4, b=7)"

      methodOne = @methodRuby.get_method(input)
      expect(methodOne.parameters).to match_array([{"a"=>"4"}, {"b"=>"7"}])
    end

    it "Parameters with whitespace between them." do
      input = "def xpto_method(a=7,               b=8, c =      0, d = 324)"

      methodOne = @methodRuby.get_method(input)
      expect(methodOne.parameters).to match_array([{"a"=>"7"}, {"b"=>"8"}, 
                                                  {"c"=>"0"}, {"d"=>"324"}])
    end

    it "Parameters with whitespace between assignment." do
      input = "def xpto_method(a        =  7,b =8, c  =  0,d    = 324)"

      methodOne = @methodRuby.get_method(input)
      expect(methodOne.parameters).to match_array([{"a"=>"7"}, {"b"=>"8"}, 
                                                  {"c"=>"0"}, {"d"=>"324"}])

    end

    it "No parameter, just parenthesis" do
      input = "def xpto_method()"

      methodOne = @methodRuby.get_method(input)
      expect(methodOne.parameters).to eq([])
    end
  end

  after :all do
    @methodRuby = nil
  end

end
