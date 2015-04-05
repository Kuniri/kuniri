require_relative '../../spec_helper'

RSpec.describe Languages::RubySyntaxSupport do

  before :all do
    @supportTest = Languages::RubySyntaxSupport.new
  end

  context "When apply regex." do
    it "Apply match regex." do
      result = @supportTest.apply_regex("test", /test/)
      expect("test".scan(/test/)[0] == result).to be true
    end

    it "Apply no match regex." do
      result = @supportTest.apply_regex("abc", /test/)
      expect(result).to eq(nil)
    end
  end

  context "When try to get class." do
    it "Match class" do
      result = @supportTest.get_class_name("  class Xpto")
      expect(result.name).to eq("Xpto")
    end

    it "No Match class" do
      result = @supportTest.get_class_name(" No class here")
      expect(result).to eq(nil)
    end
  end

  context "When try to get attribute" do
    it "Match attribute" do
      result = @supportTest.get_attribute(" @xpto = 19")
      expect(result[0].name).to eq("xpto")
    end

    it "No match attribute" do
      result = @supportTest.get_attribute(" def abc")
      expect(result).to eq(nil)
    end
  end

  context "When try to get function." do
    it "Match function" do
      result = @supportTest.get_function("  def function")
      expect(result.name).to eq("function")
    end

    it "No match function" do
      result = @supportTest.get_function(" class Function")
      expect(result).to eq(nil)
    end
  end

  context "When try to get method." do
    it "Match method." do
      result = @supportTest.get_method("   def abc")
      expect(result.name).to eq("abc")
    end

    it "No match method." do
      result = @supportTest.get_method("  abc")
      expect(result).to eq(nil)
    end
  end

  context "When try to get constructor." do
    it "Match constructor" do
      result = @supportTest.get_constructor(" def initialize")
      expect(result.name).to eq("initialize")
    end

    it "No match constructor" do
      result = @supportTest.get_constructor(" initialize = 12")
      expect(result).to eq(nil)
    end
  end

  context "When try to get extern requirements." do
    it "Match requirement" do
      result = @supportTest.get_extern_requirement("require_relative 'xpto'")
      expect(result).to eq("xpto")
    end

    it "No match requirement" do
      result = @supportTest.get_extern_requirement("include 'xpto'")
      expect(result).to eq(nil)
    end
  end

  context "When match begin." do
    it "Match begin" do
      result = @supportTest.get_begin("begin")
      expect(result).to eq("begin")
    end

    it "No match begin" do
      result = @supportTest.get_begin("raise")
      expect(result).to eq(nil)
    end
  end

  context "When match case." do
    it "Match case" do
      result = @supportTest.get_case("case")
      expect(result).to eq("case")
    end

    it "No match case" do
      result = @supportTest.get_case("if")
      expect(result).to eq(nil)
    end
  end

  context "When match do." do
    it "Match do" do
      result = @supportTest.get_do("do")
      expect(result).to eq("do")
    end

    it "No match do" do
      result = @supportTest.get_do("case")
      expect(result).to eq(nil)
    end
  end

  context "When match if" do
    it "Match if" do
      result  = @supportTest.get_if("if")
      expect(result).to eq("if")
    end

    it "No match if" do
      result = @supportTest.get_if("do")
      expect(result).to eq(nil)
    end
  end

  context "When match module" do
    it "Match module" do
      result = @supportTest.get_module("module")
      expect(result).to eq("module")
    end

    it "No match module" do
      result = @supportTest.get_module("abc")
      expect(result).to eq(nil)
    end
  end

  context "When match unless" do
    it "Match unless" do
      result = @supportTest.get_unless("unless")
      expect(result).to eq("unless")
    end

    it "No match unless" do
      result = @supportTest.get_unless("if")
      expect(result).to eq(nil)
    end
  end

  after :all do
    @supportTest = nil
  end

end
