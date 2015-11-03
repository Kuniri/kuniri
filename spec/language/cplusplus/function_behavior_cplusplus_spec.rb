require_relative '../../spec_helper'

RSpec.describe Languages::Cplusplus::FunctionBehaviorCplusplus do

  before :all do
    @functionBehaviorCplusplus = Languages::Cplusplus::FunctionBehaviorCplusplus.new
  end

  context "When method without parameters" do
    it "Common declaration." do
      input = "void Xpto::xpto_method()"
      expect(@functionBehaviorCplusplus.get_function(input).name)
              .to eq("xpto_method")
    end


    it "With whitespace in the beginning." do
      input = "   void Xpto::xpto_method()"
      expect(@functionBehaviorCplusplus.get_function(input).name)
              .to eq("xpto_method")
    end

    it "With whitespace at the end." do
      input = "int Xpto::xpto_method() "
      expect(@functionBehaviorCplusplus.get_function(input).name)
              .to eq("xpto_method")
    end

    it "Between whitespace." do
      input = "   AnyType Xpto::xpto_method() "
      expect(@functionBehaviorCplusplus.get_function(input).name)
              .to eq("xpto_method")
    end

    it "Whitespace between def and method name." do
      input = "int Xpto :: xpto_method ()"
      expect(@functionBehaviorCplusplus.get_function(input).name)
              .to eq("xpto_method")
    end
  end

  context "With parameters" do
    it "Take method name" do
      input = "void Xpto::xpto_method(int a,double b)\n"
      expect(@functionBehaviorCplusplus.get_function(input).name)
              .to eq("xpto_method")
    end

    it "Whitespace in the beginning." do
      input = "   void Xpto::xpto_method(int a,double b)\n"
      expect(@functionBehaviorCplusplus.get_function(input).name)
              .to eq("xpto_method")
    end

    it "Whitespace in the end." do
      input = "int Xpto::xpto_method(int a,double b)   "
      expect(@functionBehaviorCplusplus.get_function(input).name)
              .to eq("xpto_method")
    end

    it "Between whitespace." do
      input = "   double Xpto  ::  xpto_method  (int a,double b)   \n"
      expect(@functionBehaviorCplusplus.get_function(input).name)
              .to eq("xpto_method")
    end

    it "Spaces between parameters." do
      input = "void Xpto::xpto_method(  int a,   double b  )\n"
      expect(@functionBehaviorCplusplus.get_function(input).name)
              .to eq("xpto_method")
    end

    it "Many whitespace between method name and parameters." do
      input = "  void   Xpto  ::  xpto_method (int a ,   double b   )   \n"
      expect(@functionBehaviorCplusplus.get_function(input).name)
              .to eq("xpto_method")
    end
  end

  context "When has parameters and parenthesis." do
    it "One parameter" do
      input = "void Xpto::xpto_method(int a)\n"

      methodOne = @functionBehaviorCplusplus.get_function(input)
      expect(methodOne.parameters).to match_array(["int a"])
    end

    it "One parameter, with whitespace" do
      input = "void Xpto::xpto_method(  int a  )\n"

      methodOne = @functionBehaviorCplusplus.get_function(input)
      expect(methodOne.parameters).to match_array(["int a"])
    end

    it "Two parameters" do
      input = "void Xpto::xpto_method(int a, double b)"

      methodOne = @functionBehaviorCplusplus.get_function(input)
      expect(methodOne.parameters).to match_array(["int a", "double b"])
    end

    it "Three parameters" do
      input = "void Xpto::xpto_method(int a, double b, void *p)"

      methodOne = @functionBehaviorCplusplus.get_function(input)
      expect(methodOne.parameters).to match_array(["int a", "double b", "void *p"])
    end

    it "Three parameters, with whitespace." do
      input = " void Xpto::xpto_method(  int a  ,   double b  ,  void *p  )"

      methodOne = @functionBehaviorCplusplus.get_function(input)
      expect(methodOne.parameters).to match_array(["int a", "double b", "void *p"])
    end
  end

  #   it "One parameter with assignment" do
  #     input = "def xpto_method(a=3)"

  #     methodOne = @functionBehaviorCplusplus.get_function(input)
  #     expect(methodOne.parameters).to match_array([{"a"=>"3"}])
  #   end

  #   it "Two parameters with assignment" do
  #     input = "def xpto_method(a=4, b=7)"

  #     methodOne = @functionBehaviorCplusplus.get_function(input)
  #     expect(methodOne.parameters).to match_array([{"a"=>"4"}, {"b"=>"7"}])
  #   end

  #   it "Parameters with whitespace between them." do
  #     input = "def xpto_method(a=7,               b=8, c =      0, d = 324)"

  #     methodOne = @functionBehaviorCplusplus.get_function(input)
  #     expect(methodOne.parameters).to match_array([{"a"=>"7"}, {"b"=>"8"},
  #                                                 {"c"=>"0"}, {"d"=>"324"}])
  #   end

  #   it "Parameters with whitespace between assignment." do
  #     input = "def xpto_method(a        =  7,b =8, c  =  0,d    = 324)"

  #     methodOne = @functionBehaviorCplusplus.get_function(input)
  #     expect(methodOne.parameters).to match_array([{"a"=>"7"}, {"b"=>"8"},
  #                                                 {"c"=>"0"}, {"d"=>"324"}])

  #   end

  #   it "No parameter, just parenthesis" do
  #     input = "def xpto_method()"

  #     methodOne = @functionBehaviorCplusplus.get_function(input)
  #     expect(methodOne.parameters).to eq([])
  #   end
  # end

  after :all do
    @functionBehaviorCplusplus = nil
  end

end
