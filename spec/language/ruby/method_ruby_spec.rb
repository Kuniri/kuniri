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

#  context "When has parameters, take it." do
#    it "Take method parameters" do
#      input = "def xpto_method(a, b, c)"
#      # listOfAttribute = @methodRuby.get_method(input).attribute
#    end
#  end

  after :all do
    @methodRuby = nil
  end

end  
