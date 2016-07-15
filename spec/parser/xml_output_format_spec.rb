require_relative '../spec_helper'

RSpec.describe Parser::XMLOutputFormat do

  before :each do
    @outputFormat = Parser::XMLOutputFormat.new
    @stringHeader = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
  end

  context "Generate class" do

   it "::Simple case class" do
      expectedString = @stringHeader
      expectedString += "<classData name=\"Xpto\" visibility=\"public\">\n"
      expectedString += "</classData>\n"
      classTmp = Languages::ClassData.new
      classTmp.name = "Xpto"
      @outputFormat.class_generate([classTmp])
      expect(@outputFormat.outputEngine.to_xml).to eq(expectedString)
    end

   it "::Set visibility" do
      expectedString = @stringHeader
      expectedString += "<classData name=\"Xpto\" visibility=\"private\">\n"
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

   it "::Set aggregation" do
     expectedString = @stringHeader
     expectedString += "<aggregationData name=\"Class1\"/>\n"
     aggregationTmp = Languages::AggregationData.new "Class1"
     @outputFormat.aggregation_generate([aggregationTmp])
     expect(@outputFormat.outputEngine.to_xml).to eq(expectedString)
   end


  end

  context "Generate constructor" do

    it "::Simple constructor" do
      expectedString = @stringHeader
      expectedString += "<constructorData name=\"initialize\" "
      expectedString += "visibility=\"public\">\n"
      expectedString += "</constructorData>\n"
      constructorTmp = Languages::ConstructorData.new("initialize")
      @outputFormat.function_behaviour_generate("constructorData",
                                                constructorTmp)
      expect(@outputFormat.outputEngine.to_xml).to eq(expectedString)
    end

    it "::Constructor with comment" do
      expectedString = @stringHeader
      expectedString += "<constructorData name=\"initialize\" "
      expectedString += "visibility=\"public\">\n"
      expectedString += "  <commentData text=\"Comment constructor\"/>\n"
      expectedString += "</constructorData>\n"
      constructorTmp = Languages::ConstructorData.new("initialize")
      constructorTmp.comments = "Comment constructor"
      @outputFormat.function_behaviour_generate("constructorData",
                                                constructorTmp)
      expect(@outputFormat.outputEngine.to_xml).to eq(expectedString)
    end

    it "::Constructor with conditional" do
      expectedString = @stringHeader
      expectedString += "<constructorData name=\"initialize\" "
      expectedString += "visibility=\"public\">\n"
      expectedString += '  <if expression="(x &lt; 3)" level="0"/>'
      expectedString += "\n</constructorData>\n"

      constructorTmp = Languages::ConstructorData.new("initialize")
      conditionalTmp = Languages::ConditionalData.new
      conditionalTmp.type = Languages::IF_LABEL
      conditionalTmp.expression = "(x < 3)"

      constructorTmp.add_conditional(conditionalTmp)

      @outputFormat.function_behaviour_generate("constructorData",
                                                constructorTmp)
      expect(@outputFormat.outputEngine.to_xml).to eq(expectedString)
    end

    it "::Constructor with repetition" do
      expectedString = @stringHeader
      expectedString += "<constructorData name=\"initialize\" "
      expectedString += "visibility=\"public\">\n"
      expectedString += '  <for expression="i in x" level="0"/>'
      expectedString += "\n</constructorData>\n"

      constructorTmp = Languages::ConstructorData.new("initialize")
      conditionalTmp = Languages::RepetitionData.new
      conditionalTmp.type = Languages::FOR_LABEL
      conditionalTmp.expression = "i in x"

      constructorTmp.add_repetition(conditionalTmp)

      @outputFormat.function_behaviour_generate("constructorData",
                                                constructorTmp)
      expect(@outputFormat.outputEngine.to_xml).to eq(expectedString)
    end

    it "::Constructor with conditional and repetition" do
      expectedString = @stringHeader
      expectedString += "<constructorData name=\"initialize\" "
      expectedString += "visibility=\"public\">\n"
      expectedString += '  <if expression="(x &lt; 3)" level="0"/>' + "\n"
      expectedString += '  <for expression="i in x" level="0"/>'
      expectedString += "\n</constructorData>\n"

      constructorTmp = Languages::ConstructorData.new("initialize")

      conditionalTmp = Languages::ConditionalData.new
      conditionalTmp.type = Languages::IF_LABEL
      conditionalTmp.expression = "(x < 3)"
      constructorTmp.add_conditional(conditionalTmp)

      conditionalTmp = Languages::RepetitionData.new
      conditionalTmp.type = Languages::FOR_LABEL
      conditionalTmp.expression = "i in x"
      constructorTmp.add_repetition(conditionalTmp)

      @outputFormat.function_behaviour_generate("constructorData",
                                                constructorTmp)
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
      expectedString += "<methodData name=\"xpto\" visibility=\"public\">\n"
      expectedString += "</methodData>\n"
      methodTmp = Languages::MethodData.new("xpto")
      @outputFormat.function_behaviour_generate("methodData", methodTmp)
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
      expectedString = @stringHeader
      expectedString += "<attributeData name=\"xpto\" "
      expectedString += "visibility=\"public\"/>\n"
      attributeTmp = Languages::AttributeData.new("xpto")
      @outputFormat.attribute_generate([attributeTmp])
      expect(@outputFormat.outputEngine.to_xml).to eq(expectedString)
    end

    it "Generate function" do
      expectedString = @stringHeader
      expectedString += '<functionData name="xpto" visibility="global">'
      expectedString += "\n</functionData>\n"
      functionTmp = Languages::FunctionData.new("xpto")
      functionTmp.visibility = "global"
      @outputFormat.function_behaviour_generate("functionData", functionTmp)
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
      expectedString = @stringHeader
      expectedString += "<externRequirementData name=\"xpto\"/>\n"
      requireTmp = Languages::ExternRequirementData.new("xpto")
      @outputFormat.extern_requirement_generate([requireTmp])
      expect(@outputFormat.outputEngine.to_xml).to eq(expectedString)
    end

    it "Generate module" do
      expectedString = @stringHeader
      expectedString += "<moduleData name=\"xpto\"/>\n"
      moduleTmp = Languages::ModuleNamespaceData.new("xpto")
      @outputFormat.module_generate([moduleTmp])
      expect(@outputFormat.outputEngine.to_xml).to eq(expectedString)
    end

    it "Generate repetition" do
      expectedString = @stringHeader
      expectedString += "<while expression=\"x&gt;3\" level=\"0\"/>\n"
      repetitionTmp = Languages::RepetitionData.new
      repetitionTmp.type = Languages::WHILE_LABEL
      repetitionTmp.expression = "x>3"
      @outputFormat.basic_structure_generate([repetitionTmp])
      expect(@outputFormat.outputEngine.to_xml).to eq(expectedString)
    end

  end

  context 'Output conditional' do
    it 'Generate conditional' do
      expectedString = @stringHeader
      expectedString += "<if expression=\"y &lt; 3\" level=\"0\"/>\n"
      conditionalTmp = Languages::ConditionalData.new
      conditionalTmp.type = Languages::IF_LABEL
      conditionalTmp.expression = 'y < 3'
      @outputFormat.basic_structure_generate([conditionalTmp])
      expect(@outputFormat.outputEngine.to_xml).to eq(expectedString)
    end
  end

  context 'Full test of the output' do
    before :each do
      @path = './spec/parser/.kuniri.yml'
      @kuniri = Kuniri::Kuniri.new
      @kuniri.read_configuration_file(@path)
      @kuniri.run_analysis
      parser = Parser::XMLOutputFormat.new(@kuniri.configurationInfo[:output])
      parser.create_all_data(@kuniri.get_parser())
      @output = File.open('./spec/parser/fullCode.xml', 'r')
    end

    it 'Find first conditional directly in the file_element structure' do
      @conditional_name = nil
      @output.each do |line|
        @conditional_name = line =~ /\s+<if\sexpression="$abc > 3"\slevel="0"\/?>/
        break unless @conditional_name.nil?
      end
      expect(@conditional_name).not_to be_nil
    end

  end

  after :each do
    @outputFormat = nil
  end
end
