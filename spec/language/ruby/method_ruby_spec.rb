require_relative '../../spec_helper'

RSpec.describe Languages::Ruby::MethodRuby do

  before :all do
    @methodRuby = Languages::Ruby::MethodRuby.new
  end

  context "When method without parameter" do
    it "Simple declaration" do
      input = "def xpto"
      expect(@methodRuby.get_method(input).name)
             .to eq("xpto")
    end

    it "With spaces in the begin" do
      input = "         def xpto"
      expect(@methodRuby.get_method(input).name)
             .to eq("xpto")
    end

    it "With spaces in the begin and between method name" do
      input = "        def     xpto"
      expect(@methodRuby.get_method(input).name)
             .to eq("xpto")
      input = "                 def             xpto"
      expect(@methodRuby.get_method(input).name)
             .to eq("xpto")
    end

    it "With spaces in the end" do
      input = "def xpto                   "
      expect(@methodRuby.get_method(input).name)
             .to eq("xpto")
      input = "def              xpto                   "
      expect(@methodRuby.get_method(input).name)
             .to eq("xpto")
    end

    it "With spaces in both sides" do
      input = "           def             xpto              "
      expect(@methodRuby.get_method(input).name)
             .to eq("xpto")
    end

  end

  after :all do
    @constructor = nil
  end

end 
