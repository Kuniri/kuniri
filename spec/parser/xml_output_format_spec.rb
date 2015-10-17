require_relative '../spec_helper'

RSpec.describe Parser::XMLOutputFormat do

  before :each do
    @outputFormat = Parser::XMLOutputFormat.new
    @stringHeader = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
  end

  context "Generate class" do

   it "::Simple case class" do
      expectedString = @stringHeader
      expectedString += "<classData name=\"Xpto\" visibility=\"public\">"
      expectedString += "</classData>\n"
      classTmp = Languages::ClassData.new
      classTmp.name = "Xpto"
      @outputFormat.class_generate([classTmp])
      expect(@outputFormat.outputEngine.to_xml).to eq(expectedString)
    end

   it "::Set visibility" do
      expectedString = @stringHeader
      expectedString += "<classData name=\"Xpto\" visibility=\"private\">"
      expectedString += "</classData>\n"
      classTmp = Languages::ClassData.new
      classTmp.name = "Xpto"
      classTmp.visibility = "private"
      @outputFormat.class_generate([classTmp])
      expect(@outputFormat.outputEngine.to_xml).to eq(expectedString)
    end

   it "::Set comment" do
      expectedString = @stringHeader
      expectedString += "<classData name=\"Xpto\" visibility=\"public\">\n"
      expectedString += "  <commentData text=\"This is a simple comment\"/>\n"
      expectedString += "</classData>\n"
      classTmp = Languages::ClassData.new
      classTmp.name = "Xpto"
      classTmp.comments = "This is a simple comment"
      @outputFormat.class_generate([classTmp])
      expect(@outputFormat.outputEngine.to_xml).to eq(expectedString)
    end

  end

  context "Generate constructor" do

    it "::Simple constructor" do
      expectedString = @stringHeader
      expectedString += "<constructorData name=\"initialize\" "
      expectedString += "visibility=\"public\">"
      expectedString += "</constructorData>\n"
      constructorTmp = Languages::ConstructorData.new("initialize")
      @outputFormat.constructor_generate(constructorTmp)
      expect(@outputFormat.outputEngine.to_xml).to eq(expectedString)
    end

    it "::Constructor with parameters" do
      expectedString = @stringHeader
      expectedString += "<constructorData name=\"initialize\" "
      expectedString += "visibility=\"public\">\n"
      expectedString += "  <commentData text=\"Comment constructor\"/>\n"
      expectedString += "</constructorData>\n"
      constructorTmp = Languages::ConstructorData.new("initialize")
      constructorTmp.comments = "Comment constructor"
      @outputFormat.constructor_generate(constructorTmp)
      expect(@outputFormat.outputEngine.to_xml).to eq(expectedString)
    end

  end

  context "::Generate initialize" do

    it "::Simple inheritance" do
      expectedString = @stringHeader
      expectedString += "<inheritanceData name=\"Xpto\"/>\n"
      inheritanceTmp = Languages::ClassData.new
      inheritanceTmp.inheritances.push("Xpto")
      @outputFormat.inheritance_generate(inheritanceTmp.inheritances)
      expect(@outputFormat.outputEngine.to_xml).to eq(expectedString)
    end

    it "::Double inheritance" do
      expectedString = @stringHeader
      expectedString += "<inheritanceData name=\"Xpto1\"/>\n\n"
      expectedString += "<inheritanceData name=\"Xpto2\"/>\n"
      inheritanceTmp = Languages::ClassData.new
      inheritanceTmp.inheritances.push("Xpto1")
      inheritanceTmp.inheritances.push("Xpto2")
      @outputFormat.inheritance_generate(inheritanceTmp.inheritances)
      expect(@outputFormat.outputEngine.to_xml).to eq(expectedString)
    end

    it "::No inheritance" do
      expectedString = @stringHeader.gsub("\n", "")
      inheritanceTmp = Languages::ClassData.new
      @outputFormat.inheritance_generate(inheritanceTmp.inheritances)
      expect(@outputFormat.outputEngine.to_xml).to eq(expectedString)
    end

  end

  context "::Generate methods" do

    it "::Generate simple method" do
      expectedString = @stringHeader
      expectedString += "<methodData name=\"xpto\" visibility=\"public\">"
      expectedString += "</methodData>\n"
      methodTmp = Languages::MethodData.new("xpto")
      @outputFormat.method_generate(methodTmp)
      expect(@outputFormat.outputEngine.to_xml).to eq(expectedString)
    end

  end

  context "Cannot call unimplemented method." do

    it "Create all data" do
      expect(@outputFormat.create_all_data(nil)).to eq(nil)
    end

    it "Generate parameters" do
      expectedString = @stringHeader
      expectedString += "<parameterData name=\"value=1\"/>\n"
      parameterTmp = {"value" => "1"}
      @outputFormat.parameters_generate(parameterTmp)
      expect(@outputFormat.outputEngine.to_xml).to eq(expectedString)
    end

    it "Generate attribute" do
      attributeTmp = Languages::AttributeData.new("xpto")
      ret = @outputFormat.attribute_generate(attributeTmp)
      expect(ret).to eq("<attribute name=xpto />")
    end

    it "Generate function" do
      expectedString = @stringHeader
      expectedString += "<functionData name=\"xpto\">"
      expectedString += "</functionData>\n"
      functionTmp = Languages::FunctionData.new("xpto")
      @outputFormat.function_generate([functionTmp])
      expect(@outputFormat.outputEngine.to_xml).to eq(expectedString)
    end

    it "Generate global variable" do
      expectedString = @stringHeader
      expectedString += "<globalVariableData name=\"xpto\"/>\n"
      globalVariableTmp = Languages::VariableGlobalData.new("xpto")
      @outputFormat.global_variable_generate([globalVariableTmp])
      expect(@outputFormat.outputEngine.to_xml).to eq(expectedString)
    end

    it "Generate require" do
      requireTmp = Languages::ExternRequirementData.new("xpto")
      ret = @outputFormat.extern_requirement_generate(requireTmp)
      expect(ret).to eq("<externRequirementData name=\"xpto\" />")
    end

    it "Generate module" do
      expectedString = @stringHeader
      expectedString += "<moduleData name=\"xpto\"/>\n"
      moduleTmp = Languages::ModuleNamespaceData.new("xpto")
      @outputFormat.module_generate([moduleTmp])
      expect(@outputFormat.outputEngine.to_xml).to eq(expectedString)
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

  after :each do
    @outputFormat = nil
  end

end
