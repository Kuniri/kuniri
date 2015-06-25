require_relative '../../spec_helper'

RSpec.describe Languages::RubySyntax do

  before :each do
    @syntax = Languages::RubySyntax.new
  end

  context "Extern requirement detections." do

    it "Correct state transition (require_relative)." do
      path = "spec/samples/rubySyntaxParts/extern/requireRelative.rb"

      expect(@syntax.state)
          .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)

      @syntax.analyse_source(path)

      expect(@syntax.state)
          .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
    end

    it "Correct data capture (require_relative)." do
      path = "spec/samples/rubySyntaxParts/extern/requireRelative.rb"

      @syntax.analyse_source(path)
      expect(@syntax.fileElements[0].extern_requirements[0].name).to eq ("one")
      expect(@syntax.fileElements[0].extern_requirements[1].name).to eq ("two")
      expect(@syntax.fileElements[0].extern_requirements[2].name)
        .to eq ("three")
      expect(@syntax.fileElements[0].extern_requirements[3].name)
        .to eq ("four")
      expect(@syntax.fileElements[0].extern_requirements[4].name)
        .to eq ("five")
      expect(@syntax.fileElements[0].extern_requirements[5].name).to eq ("six")
      expect(@syntax.fileElements[0].extern_requirements.size).to eq (6)
    end

    it "Correct state transition (require)." do
      path = "spec/samples/rubySyntaxParts/extern/simpleExternRequirement.rb"

      expect(@syntax.state)
          .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
      @syntax.analyse_source(path)
      expect(@syntax.state)
          .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
    end

    it "Correct data capture (require)." do
      path = "spec/samples/rubySyntaxParts/extern/simpleExternRequirement.rb"

      @syntax.analyse_source(path)
      expect(@syntax.fileElements[0].extern_requirements[0].name).to eq ("one")
      expect(@syntax.fileElements[0].extern_requirements[1].name).to eq ("two")
      expect(@syntax.fileElements[0].extern_requirements[2].name)
        .to eq ("three")
      expect(@syntax.fileElements[0].extern_requirements[3].name)
        .to eq ("four")
      expect(@syntax.fileElements[0].extern_requirements[4].name)
        .to eq ("five")
      expect(@syntax.fileElements[0].extern_requirements[5].name).to eq ("six")
      expect(@syntax.fileElements[0].extern_requirements[6].name)
        .to eq ("seven")
      expect(@syntax.fileElements[0].extern_requirements[7].name)
        .to eq ("eight")
      expect(@syntax.fileElements[0].extern_requirements[8].name)
        .to eq ("nine")
      expect(@syntax.fileElements[0].extern_requirements.size).to eq (9)
    end

  end

  context "Global variable declarations." do
    it "Correct state transition" do
      path = "spec/samples/rubySyntaxParts/variable/simpleVariable.rb"
      expect(@syntax.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
      @syntax.analyse_source(path)
      expect(@syntax.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
    end

    it "Correct data capture (global variable)." do
      path = "spec/samples/rubySyntaxParts/variable/simpleVariable.rb"

      @syntax.analyse_source(path)
      expect(@syntax.fileElements[0].global_variables[0].name).to eq("one")
      expect(@syntax.fileElements[0].global_variables[1].name).to eq("two")
      expect(@syntax.fileElements[0].global_variables[2].name).to eq("three")
      expect(@syntax.fileElements[0].global_variables[3].name).to eq("four")
      expect(@syntax.fileElements[0].global_variables[4].name).to eq("five")
      expect(@syntax.fileElements[0].global_variables[5].name).to eq("six")
      expect(@syntax.fileElements[0].global_variables[6].name).to eq("seven")
      expect(@syntax.fileElements[0].global_variables[7].name).to eq("eight")
    end
  end

  context "Global function" do
    it "Correct state transition function." do
      path = "spec/samples/rubySyntaxParts/function/simpleFunction.rb"
      expect(@syntax.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
      @syntax.analyse_source(path)
      expect(@syntax.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
    end

    it "Correct data capture (global function)" do
      path = "spec/samples/rubySyntaxParts/function/simpleFunction.rb"

      @syntax.analyse_source(path)
      expect(@syntax.fileElements[0].global_functions[0].name)
        .to eq("simpleFunction1")
      expect(@syntax.fileElements[0].global_functions[1].name)
        .to eq("simpleFunction2")
      expect(@syntax.fileElements[0].global_functions[2].name)
        .to eq("simpleFunction3")
      expect(@syntax.fileElements[0].global_functions[3].name)
        .to eq("simpleFunction4")
      expect(@syntax.fileElements[0].global_functions[4].name)
        .to eq("simpleFunction5")
      expect(@syntax.fileElements[0].global_functions[5].name)
        .to eq("simpleFunction6")
      expect(@syntax.fileElements[0].global_functions[6].name)
        .to eq("simpleFunction7")
    end
  end

  context "Module declaration." do
    it "Correct state transition." do
      path = "spec/samples/rubySyntaxParts/module/simpleModule.rb"
      expect(@syntax.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
      @syntax.analyse_source(path)
      expect(@syntax.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
    end

    it "Correct data capture (module)" do
      path = "spec/samples/rubySyntaxParts/module/simpleModule.rb"

      @syntax.analyse_source(path)
      expect(@syntax.fileElements[0].modules[0].name)
        .to eq("Xpto")
      expect(@syntax.fileElements[0].modules[1].name)
        .to eq("Abc")
      expect(@syntax.fileElements[0].modules[2].name)
        .to eq("Simple")
    end
  end

  context "Class declaration" do
    it "Correct state transition." do
      path = "spec/samples/rubySyntaxParts/class/simpleClass.rb"

      expect(@syntax.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
      @syntax.analyse_source(path)
      expect(@syntax.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
    end

    it "Correct data capture (class)." do
      path = "spec/samples/rubySyntaxParts/class/simpleClass.rb"

      @syntax.analyse_source(path)
      expect(@syntax.fileElements[0].classes[0].name).to eq("Simple1")
      expect(@syntax.fileElements[0].classes[1].name).to eq("Simple2")
      expect(@syntax.fileElements[0].classes[2].name).to eq("Simple3")
      expect(@syntax.fileElements[0].classes[3].name).to eq("Simple4")
      expect(@syntax.fileElements[0].classes[4].name).to eq("Simple5")
    end

  end

  context "Attribute line" do
    it "Correct state transition." do
      path = "spec/samples/rubySyntaxParts/attribute/simpleAttribute.rb"

      expect(@syntax.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
      @syntax.analyse_source(path)
      expect(@syntax.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
    end

    it "Correct data capture (attribute)" do
      path = "spec/samples/rubySyntaxParts/attribute/simpleAttribute.rb"

      @syntax.analyse_source(path)
      expect(@syntax.fileElements[0].classes[0].attributes[0].name)
        .to eq("attribute1")
      expect(@syntax.fileElements[0].classes[0].attributes[1].name)
        .to eq("attribute2")
      expect(@syntax.fileElements[0].classes[0].attributes[2].name)
        .to eq("attribute3")
      expect(@syntax.fileElements[0].classes[0].attributes[3].name)
        .to eq("attribute4")
      expect(@syntax.fileElements[0].classes[0].attributes[4].name)
        .to eq("attribute5")
      expect(@syntax.fileElements[0].classes[0].attributes[5].name)
        .to eq("attribute6")

    end
  end

  context "Method line" do
    it "Correct state transition." do
      path = "spec/samples/rubySyntaxParts/method/simpleMethod.rb"

      expect(@syntax.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
      @syntax.analyse_source(path)
      expect(@syntax.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
    end

    it "Correct data capture (method)" do
      path = "spec/samples/rubySyntaxParts/method/simpleMethod.rb"

      @syntax.analyse_source(path)
      expect(@syntax.fileElements[0].classes[0].methods[0].name)
        .to eq("method1")
      expect(@syntax.fileElements[0].classes[0].methods[1].name)
        .to eq("method2")
      expect(@syntax.fileElements[0].classes[0].methods[2].name)
        .to eq("method3")
    end
  end

  context "Constructor line" do
    it "Correct state transition." do
      path = "spec/samples/rubySyntaxParts/constructor/simpleConstructor.rb"

      expect(@syntax.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
      @syntax.analyse_source(path)
      expect(@syntax.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
    end

    it "Correct data capture (constructor)" do
      path = "spec/samples/rubySyntaxParts/constructor/simpleConstructor.rb"

      @syntax.analyse_source(path)
      expect(@syntax.fileElements[0].classes[0].constructors[0].name)
        .to eq("initialize")
      expect(@syntax.fileElements[0].classes[1].constructors[0].name)
        .to eq("initialize")
    end
  end

  context "Conditional line" do
    it "Correct state transition." do
      path =
        "spec/samples/rubySyntaxParts/conditionalStatment/simpleConditional.rb"

      expect(@syntax.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
      @syntax.analyse_source(path)
      expect(@syntax.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
    end

    it "Correct data capture (conditional)" do
       path =
        "spec/samples/rubySyntaxParts/conditionalStatment/simpleConditional.rb"

      @syntax.analyse_source(path)
      expect(@syntax.fileElements[0].global_functions[0].name)
        .to eq("simple1")

      expect(@syntax.fileElements[0].global_functions[0]
            .conditionals[0].expression).to eq("3 > 2")
      expect(@syntax.fileElements[0].global_functions[0]
            .conditionals[0].type).to eq("IF")

      expect(@syntax.fileElements[0].global_functions[1]
            .conditionals[0].expression).to eq("7 > 2")
      expect(@syntax.fileElements[0].classes[0].global_functions[1]
            .conditionals[0].type).to eq("IF")

      expect(@syntax.fileElements[0].global_functions[1]
            .conditionals[0].expression).to eq("\"a\" < \"k\"")
      expect(@syntax.fileElements[0].global_functions[1]
            .conditionals[0].type).to eq("IF")
    end
  end


  after :each do
    @syntax = nil
  end

end
