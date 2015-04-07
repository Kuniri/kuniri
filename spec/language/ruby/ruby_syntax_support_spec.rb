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

  context "When has end" do
    it "Match end" do
      result = @supportTest.has_end?("   end")
      expect(result).to be true
    end

    it "No match end" do
      result = @supportTest.has_end?("  noend")
      expect(result).to be false
    end
  end

  context "Match visibility" do
    it "Match visibility" do
      result = @supportTest.get_visibiliy("private")
      expect(result).to eq("private")
    end

    it "No match visibility" do
      result = @supportTest.get_visibiliy("noprivate")
      expect(result).to eq(nil)
    end
  end

  context "Find token inside class." do
    it "Get attribute" do
      result= @supportTest.get_token_type("@attr" ,true)
      expect(result).to eq(Languages::Ruby::ATTRIBUTE_TOKEN)
    end

    it "Find visibility inside class." do
      result = @supportTest.get_token_type("private", true)
      expect(result).to eq(Languages::Ruby::VISIBILITY_TOKEN)
    end
  end

  context "Find token inside code." do
    it "Find class." do
      result = @supportTest.get_token_type("  class Xpto\n")
      expect(result).to eq(Languages::Ruby::CLASS_TOKEN)
    end

    it "Find end token." do
      result = @supportTest.get_token_type("  end")
      expect(result).to eq(Languages::Ruby::END_TOKEN)
    end

    it "Find begin token." do
      result = @supportTest.get_token_type(" begin")
      expect(result).to eq(Languages::Ruby::BEGIN_TOKEN)
    end

    it "Find def token." do
      result = @supportTest.get_token_type(" def xpto")
      expect(result).to eq(Languages::Ruby::DEF_TOKEN)
    end

    it "Find case token." do
      result = @supportTest.get_token_type("  case")
      expect(result).to eq(Languages::Ruby::CASE_TOKEN)
    end

    it "Find do token." do
      result = @supportTest.get_token_type("  do")
      expect(result).to eq(Languages::Ruby::DO_TOKEN)
    end

    it "Find if token." do
      result = @supportTest.get_token_type("   if 2 > 3")
      expect(result).to eq(Languages::Ruby::IF_TOKEN)
    end

    it "Find module token." do
      result = @supportTest.get_token_type(" module xpto")
      expect(result).to eq(Languages::Ruby::MODULE_TOKEN)
    end

    it "Find unless token." do
      result = @supportTest.get_token_type(" unless 3 > 2")
      expect(result).to eq(Languages::Ruby::UNLESS_TOKEN)
    end

    it "Find require token." do
      result = @supportTest.get_token_type(" require_relative 'xpto'")
      expect(result).to eq(Languages::Ruby::REQUIRE_TOKEN)
    end

  end

  after :all do
    @supportTest = nil
  end

end
