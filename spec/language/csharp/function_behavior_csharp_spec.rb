require_relative '../../spec_helper'

RSpec.describe Languages::Csharp::FunctionBehaviorCsharp do

  before :all do
    @functionBehaviorCsharp = Languages::Csharp::FunctionBehaviorCsharp.new
  end

  context "When method without parameters with regular spaces" do
    it "Common public declaration." do
      input = "public int xpto_method()"
      expect(@functionBehaviorCsharp.get_function(input).name)
              .to eq("xpto_method")
    end

    it "Common private declaration." do
      input = "private int xpto_method()"
      expect(@functionBehaviorCsharp.get_function(input).name)
              .to eq("xpto_method")
    end

    it "Common protected declaration." do
      input = "protected int xpto_method()"
      expect(@functionBehaviorCsharp.get_function(input).name)
              .to eq("xpto_method")
    end

    it "Common static declaration." do
      input = "public static int xpto_method()"
      expect(@functionBehaviorCsharp.get_function(input).name)
              .to eq("xpto_method")
    end

    it "Common virtual declaration." do
      input = "public virtual int xpto_method()"
      expect(@functionBehaviorCsharp.get_function(input).name)
              .to eq("xpto_method")
    end

    it "Common sealed declaration." do
      input = "public sealed int xpto_method()"
      expect(@functionBehaviorCsharp.get_function(input).name)
              .to eq("xpto_method")
    end
  end

  context "When method without parameters with spaces in the scope" do
    it "With whitespace in the beginning.." do
      input = "       public int xpto_method()"
      expect(@functionBehaviorCsharp.get_function(input).name)
              .to eq("xpto_method")
    end

    it "With whitespace at the end." do
      input = "public int xpto_method()  "
      expect(@functionBehaviorCsharp.get_function(input).name)
              .to eq("xpto_method")
    end

    it "Between whitespace." do
      input = "   public int xpto_method() "
      expect(@functionBehaviorCsharp.get_function(input).name)
              .to eq("xpto_method")
    end

    it "Whitespace between scope and rest of the declaration." do
      input = "public    int xpto_method()"
      expect(@functionBehaviorCsharp.get_function(input).name)
              .to eq("xpto_method")
    end

    it "Whitespace in the beginning and between the scope." do
      input = "  public   int xpto_method()"
      expect(@functionBehaviorCsharp.get_function(input).name)
              .to eq("xpto_method")
    end

    it "Whitespace between the scope and in the end." do
      input = "public   int xpto_method()  "
      expect(@functionBehaviorCsharp.get_function(input).name)
              .to eq("xpto_method")
    end

    it "Tab in the beginning and space in the end." do
      input = "     public   int xpto_method() "
      expect(@functionBehaviorCsharp.get_function(input).name)
              .to eq("xpto_method")
    end

    it "Whitespace in the beginning and in the end." do
      input = "       public     int xpto_method()    "
      expect(@functionBehaviorCsharp.get_function(input).name)
              .to eq("xpto_method")
    end
  end

  context "When method without parameters with spaces in the return type" do
    it "With whitespace in the beginning.." do
      input = "       public int xpto_method()"
      expect(@functionBehaviorCsharp.get_function(input).name)
              .to eq("xpto_method")
    end

    it "With whitespace at the end." do
      input = "public int xpto_method()  "
      expect(@functionBehaviorCsharp.get_function(input).name)
              .to eq("xpto_method")
    end

    it "Between whitespace." do
      input = "   public int xpto_method() "
      expect(@functionBehaviorCsharp.get_function(input).name)
              .to eq("xpto_method")
    end

    it "Whitespace between return type and rest of the declaration." do
      input = "public int    xpto_method()"
      expect(@functionBehaviorCsharp.get_function(input).name)
              .to eq("xpto_method")
    end

    it "Whitespace in the beginning and between the return type." do
      input = "  public int    xpto_method()"
      expect(@functionBehaviorCsharp.get_function(input).name)
              .to eq("xpto_method")
    end

    it "Whitespace between the return type and in the end." do
      input = "public int   xpto_method()  "
      expect(@functionBehaviorCsharp.get_function(input).name)
              .to eq("xpto_method")
    end

    it "Tab in the beginning and space in the end." do
      input = "     public int    xpto_method() "
      expect(@functionBehaviorCsharp.get_function(input).name)
              .to eq("xpto_method")
    end

    it "Whitespace in the beginning and in the end." do
      input = "       public int    xpto_method()    "
      expect(@functionBehaviorCsharp.get_function(input).name)
              .to eq("xpto_method")
    end
  end

  context "With parameters" do
    it "Take method name" do
      input = "private virtual int xpto_method(int a, int b, string c){\n"
      expect(@functionBehaviorCsharp.get_function(input).name)
              .to eq("xpto_method")
    end

    it "Whitespace in the beginning." do
      input = "    private virtual int xpto_method(int a, int b, string c){\n"
      expect(@functionBehaviorCsharp.get_function(input).name)
              .to eq("xpto_method")
    end

    it "Whitespace in the end." do
      input = "private virtual int xpto_method(int a, int b, string c){     \n"
      expect(@functionBehaviorCsharp.get_function(input).name)
              .to eq("xpto_method")
    end

    it "Between whitespace." do
      input = "    private virtual int xpto_method(int a,int b,string c){   \n"
      expect(@functionBehaviorCsharp.get_function(input).name)
              .to eq("xpto_method")
    end

    it "Spaces between parameters." do
      input = "private virtual int xpto_method(int a, int b, string c)\n"
      expect(@functionBehaviorCsharp.get_function(input).name)
              .to eq("xpto_method")
    end

    it "Many whitespace between method name and parameters." do
      input = "  private virtual int xpto_method     (int a, int b, string c)\n"
      expect(@functionBehaviorCsharp.get_function(input).name)
              .to eq("xpto_method")
    end

    it "Many whitespace between method declaration." do
      input = "private virtual int   xpto_method   (int a, int b, string  c) \n"
      expect(@functionBehaviorCsharp.get_function(input).name)
              .to eq("xpto_method")
    end

    it "Different whitespace patterns." do
      input = "  private   virtual  int  xpto_method  (int a,   int b,  string  c)   \n"
      expect(@functionBehaviorCsharp.get_function(input).name)
              .to eq("xpto_method")
    end
  end

  context "When has parameters and parenthesis." do
    it "One parameter" do
      input = "private virtual int xpto_method (int a)"

      methodOne = @functionBehaviorCsharp.get_function(input)
      expect(methodOne.parameters).to match_array(["int a"])
    end

    it "Two parameters" do
      input = "private virtual int xpto_method(int a, int b)"

      methodOne = @functionBehaviorCsharp.get_function(input)
      expect(methodOne.parameters).to match_array(["int a", "int b"])
    end

    it "Three parameters" do
      input = "private virtual int xpto_method(int a, int b, string c)"

      methodOne = @functionBehaviorCsharp.get_function(input)
      expect(methodOne.parameters)
            .to match_array(["int a", "int b", "string c"])
    end

    it "Three parameters, with whitespace." do
      input = "private virtual int xpto_method(int a ,  int b , string c)   "

      methodOne = @functionBehaviorCsharp.get_function(input)
      expect(methodOne.parameters)
            .to match_array(["int a", "int b", "string c"])
    end


  #   it "One parameter with assignment" do
  #     input = "def xpto_method(a=3)"

  #     methodOne = @functionBehaviorCsharp.get_function(input)
  #     expect(methodOne.parameters).to match_array([{"a"=>"3"}])
  #   end

  #   it "Two parameters with assignment" do
  #     input = "def xpto_method(a=4, b=7)"

  #     methodOne = @functionBehaviorCsharp.get_function(input)
  #     expect(methodOne.parameters).to match_array([{"a"=>"4"}, {"b"=>"7"}])
  #   end

  #   it "Parameters with whitespace between them." do
  #     input = "def xpto_method(a=7,               b=8, c =      0, d = 324)"

  #     methodOne = @functionBehaviorCsharp.get_function(input)
  #     expect(methodOne.parameters).to match_array([{"a"=>"7"}, {"b"=>"8"}, 
  #                                                 {"c"=>"0"}, {"d"=>"324"}])
  #   end

  #   it "Parameters with whitespace between assignment." do
  #     input = "def xpto_method(a        =  7,b =8, c  =  0,d    = 324)"

  #     methodOne = @functionBehaviorCsharp.get_function(input)
  #     expect(methodOne.parameters).to match_array([{"a"=>"7"}, {"b"=>"8"}, 
  #                                                 {"c"=>"0"}, {"d"=>"324"}])

  #   end

  #   it "No parameter, just parenthesis" do
  #     input = "def xpto_method()"

  #     methodOne = @functionBehaviorCsharp.get_function(input)
  #     expect(methodOne.parameters).to eq([])
  #   end
  end


  # context "When has parameters and no parenthesis." do
  #   it "No parenthesis, and one parameter" do
  #     input = "def xpto_method x"
  #     methodOne = @functionBehaviorCsharp.get_function(input)
  #     expect(methodOne.parameters).to match_array(["x"])
  #   end

  #   it "One parameter, with space at the end." do
  #     input = "def xpto_method x       "
  #     methodOne = @functionBehaviorCsharp.get_function(input)
  #     expect(methodOne.parameters).to match_array(["x"])
  #   end

  #   it "One parameter, with space in the end and in the begining." do
  #     input = "def xpto_method       x           "
  #     methodOne = @functionBehaviorCsharp.get_function(input)
  #     expect(methodOne.parameters).to match_array(["x"])
  #   end

  #   it "One parameter, multiple spaces" do
  #     input = "       def xpto_method       x         "
  #     methodOne = @functionBehaviorCsharp.get_function(input)
  #     expect(methodOne.parameters).to match_array(["x"])
  #   end

  #   it "Two parameters" do
  #     input = "def xpto_method x,y"
  #     methodOne = @functionBehaviorCsharp.get_function(input)
  #     expect(methodOne.parameters).to match_array(["x", "y"])
  #   end

  #   it "Three parameters" do
  #     input = "def xpto_method x, abcde, xyz"
  #     methodOne = @functionBehaviorCsharp.get_function(input)
  #     expect(methodOne.parameters).to match_array(["x", "abcde", "xyz"])
  #   end

  #   it "Multiple parameters with many spaces" do
  #     input = " def xpto_method     x ,    m,    nda ,       t  "
  #     methodOne = @functionBehaviorCsharp.get_function(input)
  #     expect(methodOne.parameters).to match_array(["x", "m", "nda", "t"])
  #   end

  # end

  after :all do
    @functionBehaviorCsharp = nil
  end

end
