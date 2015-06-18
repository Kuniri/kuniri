require_relative '../../spec_helper'

RSpec.describe StateMachine::OOStructuredFSM::ModuleState do

  before :each do
    @rubyTest = Languages::RubySyntax.new
  end

  context "Correct flow." do

    it "Idle to module" do
      @rubyTest.state.module_capture
      expect(@rubyTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::ModuleState)
    end

    it "Module to idle" do
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

    it "Module to class" do
      @rubyTest.state.module_capture
      @rubyTest.state.class_capture
      expect(@rubyTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::ClassState)
    end

  end

  context "Incorrect flow." do

    it "Incorrect flow" do
      @rubyTest.state.module_capture
      expect{@rubyTest.method_capture}
        .to raise_error(NotImplementedError)
    end

  end

  after :each do
    @rubyTest = nil
  end

end
