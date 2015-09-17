require_relative '../spec_helper'

RSpec.describe Parser::XMLOutputFormat do

  before :all do
    @outputFormat = Parser::XMLOutputFormat.new
  end

  context "Generate class" do

   it "::Simple case class" do
      classTmp = Languages::ClassData.new
      classTmp.name = "Xpto"
      ret = @outputFormat.class_generate(classTmp)
      expect(ret).to eq("<class name=\"Xpto\" visibility=\"public\" />")
    end

   it "::Set visibility" do
      classTmp = Languages::ClassData.new
      classTmp.name = "Xpto"
      classTmp.visibility = "private"
      ret = @outputFormat.class_generate(classTmp)
      expect(ret).to eq("<class name=\"Xpto\" visibility=\"private\" />")
    end

   it "::Set comment" do
      classTmp = Languages::ClassData.new
      classTmp.name = "Xpto"
      classTmp.comments = "This is a simple comment"
      ret = @outputFormat.class_generate(classTmp)
      expect(ret).to eq("<class name=\"Xpto\" visibility=\"public\"" +
                        "\n\tcomments=\"This is a simple comment\" />")
    end

  end

  context "Cannot call unimplemented method." do

    it "Create all data" do
      ret = @outputFormat.create_data(nil)
    end
 
    it "Generate constructor" do
      constructorTmp = Languages::ConstructorData.new("initialize")
      ret = @outputFormat.constructor_generate(constructorTmp)
      expect(ret).to eq("<constructor name=\"initialize\">")
    end

    it "Generate inheritance" do
      inheritanceTmp = Languages::ClassData.new
      inheritanceTmp.inheritances = "Xpto"
      ret = @outputFormat.inheritance_generate(inheritanceTmp)
      expect(ret).to eq("<inheritance name=\"Xpto\" />")
    end

    it "Generate method" do
      methodTmp = Languages::MethodData.new("xpto")
      ret = @outputFormat.method_generate(methodTmp)
      expect(ret).to eq("<method name=\"xpto\">")
    end

    it "Generate parameters" do
      parameterTmp = Languages::MethodData.new("xpto")
      parameterTmp.add_parameters("a")
      ret = @outputFormat.parameters_generate(parameterTmp)
      expect(ret).to eq("<parameter name=\"a\"/>")
    end

    it "Generate attribute" do
      attributeTmp = Languages::AttributeData.new("xpto")
      ret = @outputFormat.attribute_generate(attributeTmp)
      expect(ret).to eq("<attribute name=xpto />")
    end

    it "Generate function" do
      functionTmp = Languages::FunctionData.new("xpto")
      ret = @outputFormat.function_generate(functionTmp)
      expect(ret).to eq("<function name=\"xpto\" >")
    end

    it "Generate global variable" do
      globalVariableTmp = Languages::VariableGlobalData.new("xpto")
      ret = @outputFormat.global_variable_generate(globalVariableTmp)
      expect(ret).to eq("<globalVariable name=\"xpto\"/>")
    end

    it "Generate require" do
      requireTmp = Languages::ExternRequirementData.new("xpto")
      ret = @outputFormat.extern_requirement_generate(requireTmp)
      expect(ret).to eq("<externRequirementData name=\"xpto\" />")
    end

    it "Generate module" do
      moduleTmp = Languages::ModuleNamespaceData("xpto")
      ret = @outputFormat.module_generate(moduleTmp)
      expect(ret).to eq("<module name=\"xpto\" />")
    end

    it "Generate repetition" do
      repetitionTmp = Languages::RepetitionData.new
      repetitionTmp.type = "while"
      ret = @outputFormat.repetition_generate(repetitionTmp)
      expect(ret).to eq("<repetiton type=\"while\" />")
    end

    it "Generate conditional" do
      conditionalTmp = Languages::ConditionalData.new
      conditionalTmp.type = "if"
      ret = @outputFormat.conditional_generate(conditionalTmp)
      expect(ret).to eq("<conditional type=\"if\" />")
    end

  end

  after :all do
    @outputFormat = nil
  end

end
