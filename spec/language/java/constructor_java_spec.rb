require_relative '../../spec_helper'

RSpec.describe Languages::Java::ConstructorJava do

  before :all do 
    @constructor = Languages::Java::ConstructorJava.new
  end

  context "When constructor with parameter" do
    it "Declaration with only one parameter" do
      input = "public  Xpto(int a)"
      expect(@constructor.get_constructor(input).name)
             .to eq("Xpto")
      expect(@constructor.get_constructor(input).parameters[0])
             .to eq("int a")
    end

    it "Declaration with two parameters" do
      input = "public  Xpto(int a, float b)"
      expect(@constructor.get_constructor(input).name)
             .to eq("Xpto")
      expect(@constructor.get_constructor(input).parameters[0])
             .to eq("int a")
      expect(@constructor.get_constructor(input).parameters[1])
             .to eq("float b")
    end

    it "Declaration with three parameters" do
      input = "public  Xpto(int a, float b, String myString)"
      expect(@constructor.get_constructor(input).name)
             .to eq("Xpto")
      expect(@constructor.get_constructor(input).parameters[0])
             .to eq("int a")
      expect(@constructor.get_constructor(input).parameters[1])
             .to eq("float b")
      expect(@constructor.get_constructor(input).parameters[2])
             .to eq("String myString")
    end

    it "Declaration with only one parameter with empty spaces" do
      input = "public  Xpto( int a )"
      expect(@constructor.get_constructor(input).name)
             .to eq("Xpto")
      expect(@constructor.get_constructor(input).parameters[0])
             .to eq("int a")

      input = "public  Xpto(int a )"
      expect(@constructor.get_constructor(input).name)
             .to eq("Xpto")
      expect(@constructor.get_constructor(input).parameters[0])
             .to eq("int a")

      input = "public  Xpto( int a)"
      expect(@constructor.get_constructor(input).name)
             .to eq("Xpto")
      expect(@constructor.get_constructor(input).parameters[0])
             .to eq("int a")
    end

    it "Declaration with two parameters with empty spaces" do
      input = "public  Xpto( int a, float b )"
      expect(@constructor.get_constructor(input).name)
             .to eq("Xpto")
      expect(@constructor.get_constructor(input).parameters[0])
             .to eq("int a")
      expect(@constructor.get_constructor(input).parameters[1])
             .to eq("float b")

      input = "public  Xpto(int a,float b )"
      expect(@constructor.get_constructor(input).name)
             .to eq("Xpto")
      expect(@constructor.get_constructor(input).parameters[0])
             .to eq("int a")
      expect(@constructor.get_constructor(input).parameters[1])
             .to eq("float b")

      input = "public  Xpto( int a,float b)"
      expect(@constructor.get_constructor(input).name)
             .to eq("Xpto")
      expect(@constructor.get_constructor(input).parameters[0])
             .to eq("int a")
      expect(@constructor.get_constructor(input).parameters[1])
             .to eq("float b")

      input = "public  Xpto( int a, float b)"
      expect(@constructor.get_constructor(input).name)
             .to eq("Xpto")
      expect(@constructor.get_constructor(input).parameters[0])
             .to eq("int a")
      expect(@constructor.get_constructor(input).parameters[1])
             .to eq("float b")

      input = "public  Xpto( int       a ,      float     b )"
      expect(@constructor.get_constructor(input).name)
             .to eq("Xpto")
      expect(@constructor.get_constructor(input).parameters[0])
             .to eq("int a")
      expect(@constructor.get_constructor(input).parameters[1])
             .to eq("float b")
    end

  end

  context "When constructor without parameter" do
    it "Simple declaration" do
      input = "public  Xpto()"
      expect(@constructor.get_constructor(input).name)
             .to eq("Xpto")
    end

    it "With spaces in the begin" do
      input = "         public Xpto()"
      expect(@constructor.get_constructor(input).name)
             .to eq("Xpto")
    end

    it "With spaces in the begin and between constructor name" do
      input = "        public     Xpto()"
      expect(@constructor.get_constructor(input).name)
             .to eq("Xpto")
      input = "                 public             Xpto()"
      expect(@constructor.get_constructor(input).name)
             .to eq("Xpto")
    end

    it "With spaces in the end" do
      input = "public Xpto()                   "
      expect(@constructor.get_constructor(input).name)
             .to eq("Xpto")
      input = "public              Xpto()                   "
      expect(@constructor.get_constructor(input).name)
             .to eq("Xpto")
    end

    it "With spaces in both sides" do
      input = "           public             Xpto()              "
      expect(@constructor.get_constructor(input).name)
             .to eq("Xpto")
    end

    it "No constructor" do
      input = "   public String Xpto()"
      expect(@constructor.get_constructor(input))
             .to eq(nil) 
    end

    it "Public access modifier" do
      input = "public  Xpto()"
      expect(@constructor.get_constructor(input).name)
             .to eq("Xpto")
    end

    it "Private access modifier" do
      input = "private  Xpto()"
      expect(@constructor.get_constructor(input).name)
             .to eq("Xpto")
    end

    it "Protected access modifier" do
      input = "protected  Xpto()"
      expect(@constructor.get_constructor(input).name)
             .to eq("Xpto")
    end

    it "Package access modifier" do
      input = "package  Xpto()"
      expect(@constructor.get_constructor(input).name)
             .to eq("Xpto")
    end

    it "Without access modifier" do
      input = "Xpto()"
      expect(@constructor.get_constructor(input).name)
             .to eq("Xpto")
    end

  end

  after :all do
    @constructor = nil
  end

end