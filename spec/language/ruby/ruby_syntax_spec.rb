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

  after :each do
    @syntax = nil
  end

end
