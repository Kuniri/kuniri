require_relative '../../spec_helper'

RSpec.describe StateMachine::OOStructuredFSM::FunctionState do

  before :each do
    @rubyTest = Languages::RubySyntax.new
  end

  context "Correct flow." do

    it "Idle to function." do
      @rubyTest.state.function_capture
      expect(@rubyTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::FunctionState)
    end

    it "Function to module." do
      @rubyTest.state.function_capture
      @rubyTest.module_capture
      expect(@rubyTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::ModuleState)
    end

    it "Function, module, to idle." do
      @rubyTest.state.function_capture
      @rubyTest.state.module_capture
      @rubyTest.state.idle_capture
      expect(@rubyTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
    end

    it "Module to function" do
      @rubyTest.state.module_capture
      @rubyTest.state.function_capture
      expect(@rubyTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::FunctionState)
    end
  end

  context "Incorrect flow." do
    it "Function to variable" do
      @rubyTest.state.function_capture
      expect{@rubyTest.variable_capture}
        .to raise_error(NotImplementedError)
    end
  end

  context "Flow based of file." do

  end

  after :each do
    @rubyTest = nil
  end

end
