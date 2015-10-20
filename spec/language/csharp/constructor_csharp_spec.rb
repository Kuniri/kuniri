require_relative '../../spec_helper'

RSpec.describe Languages::Csharp::ConstructorCsharp do

  before :all do
    @constructor = Languages::Csharp::ConstructorCsharp.new
  end

  context "When constructor without parameter" do
    it "Simple declaration" do
      input = "public Xpto()"
      expect(@constructor.get_constructor(input).name)
             .to eq("Xpto")
      expect(@constructor.get_constructor(input).type)
             .to eq("CONSTRUCTOR")
    end

    it "With spaces in the begin" do
      input = "         public Xpto()"
      expect(@constructor.get_constructor(input).name)
             .to eq("Xpto")
      expect(@constructor.get_constructor(input).type)
             .to eq("CONSTRUCTOR")
    end

    it "With spaces in the begin and between the constructor name" do
      input = "        public     Xpto()"
      expect(@constructor.get_constructor(input).name)
             .to eq("Xpto")
      input = "                 public              Xpto()"
      expect(@constructor.get_constructor(input).name)
             .to eq("Xpto")
      expect(@constructor.get_constructor(input).type)
             .to eq("CONSTRUCTOR")
    end

    it "With spaces in the end" do
      input = "public Xpto()                   "
      expect(@constructor.get_constructor(input).name)
             .to eq("Xpto")
      input = "public                    Xpto()                   "
      expect(@constructor.get_constructor(input).name)
             .to eq("Xpto")
      expect(@constructor.get_constructor(input).type)
             .to eq("CONSTRUCTOR")
    end

    it "With spaces in both sides" do
      input = "           public              Xpto()              "
      expect(@constructor.get_constructor(input).name)
             .to eq("Xpto")
      expect(@constructor.get_constructor(input).type)
             .to eq("CONSTRUCTOR")
    end

    it "No constructor" do
      input = "public int methodX()"
      expect(@constructor.get_constructor(input).type)
             .not_to eq("CONSTRUCTOR")
    end
  end

  after :all do
    @constructor = nil
  end

end 
