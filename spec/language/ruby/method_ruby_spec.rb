require_relative '../../spec_helper'

RSpec.describe Languages::Ruby::MethodRuby do

  before :all do
    @methodRuby = Languages::Ruby::MethodRuby.new
  end

  context "# Method handling" do

    it "Take method name without parameters" do
      input = "def xpto_method"
      methodName = @methodName.get_method(input).name
      expect(methodName).to eq("xpto_method")

      # Add space
      methodName = @methodName.get_method("   " + input).name
      expect(methodName).to eq("xpto_method")

      methodName = @methodName.get_method(input + " ").name
      expect(methodName).to eq("xpto_method")

      methodName = @methodName.get_method("   " + input + " ").name
      expect(methodName).to eq("xpto_method")

      # Spaces between name
      methodName = @methodName.get_method("def  xpto_method").name
      expect(methodName).to eq("xpto_method")

      methodName = @methodName.get_method("  def   xpto_method").name
      expect(methodName).to eq("xpto_method")

      methodName = @methodName.get_method("def  xpto_method    ").name
      expect(methodName).to eq("xpto_method")

      methodName = @methodName.get_method("     def  xpto_method ").name
      expect(methodName).to eq("xpto_method")

      methodName = @methodName.get_method("       def  xpto_method    ").name
      expect(methodName).to eq("xpto_method")

      methodName = @methodName.get_method("     def        xpto_method").name
      expect(methodName).to eq("xpto_method")
 
      methodName = @methodName.get_method("  def   xpto_method   ").name
      expect(methodName).to eq("xpto_method")

    end

    it "Take method name" do
      input = "def xpto_method(a, b, c, d)\n"
      methodName = @methodRuby.get_method(input).name
      expect(methodName).to eq("xpto_method")

      methodName = @methodName.get_method("    " + input).name
      expect(methodName).to eq("xpto_method")

      methodName = @methodName.get_method(input + "    ").name
      expect(methodName).to eq("xpto_method")

      methodName = @methodName.get_method("    " + input  + "  ").name
      expect(methodName).to eq("xpto_method")

      # Add space between element
      input = "def xpto_method (a, b, c, d)\n"
      methodName = @methodName.get_method(input).name
      expect(methodName).to eq("xpto_method")

      input = "  def xpto_method      (a, b, c, d)\n"
      methodName = @methodName.get_method(input).name
      expect(methodName).to eq("xpto_method")

      input = "   def    xpto_method     (   a  , b  ,      c   ,     d   ) \n"
      methodName = @methodName.get_method(input).name
      expect(methodName).to eq("xpto_method")

      input = "  def    xpto_method    (        a, b,    c, d )   \n"
      methodName = @methodName.get_method(input).name
      expect(methodName).to eq("xpto_method")

    end

    it "Take method parameters" do
      input = "def xpto_method(a, b, c)"
      # listOfAttribute = @methodName.get_method(input).attribute
    end

  end

  after :all do
    @methodRuby = nil
  end

end  
