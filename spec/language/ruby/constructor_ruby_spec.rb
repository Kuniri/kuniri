require_relative '../../spec_helper'

RSpec.describe Languages::Ruby::ConstructorRuby do

  before :all do
    @constructor = Languages::Ruby::ConstructorRuby.new
  end

  context "When constructor without parameter" do
    it "Simple declaration" do
      input = "def initialize"
      expect(@constructor.get_constructor(input).name)
             .to eq("initialize")
    end

    it "With spaces in the begin" do
      input = "         def initialize"
      expect(@constructor.get_constructor(input).name)
             .to eq("initialize")
    end

    it "With spaces in the begin and between initialize" do
      input = "        def     initialize"
      expect(@constructor.get_constructor(input).name)
             .to eq("initialize")
      input = "                 def             initialize"
      expect(@constructor.get_constructor(input).name)
             .to eq("initialize")
    end

    it "With spaces in the end" do
      input = "def initialize                   "
      expect(@constructor.get_constructor(input).name)
             .to eq("initialize")
      input = "def              initialize                   "
      expect(@constructor.get_constructor(input).name)
             .to eq("initialize")
    end

    it "With spaces in both sides" do
      input = "           def             initialize              "
      expect(@constructor.get_constructor(input).name)
             .to eq("initialize")
    end

    it "No constructor" do
      input = "   def methodX"
      expect(@constructor.get_constructor(input))
             .to eq(nil)
    end
  end

  after :all do
    @constructor = nil
  end

end 
