require_relative '../../spec_helper'

RSpec.describe StateMachine::OOStructuredFSM::IdleState do

  before :each do
    @rubyTest = Languages::RubySyntax.new
  end

  context "Correct flow." do

    it "Idle to include." do
      @rubyTest.include_capture
      expect(@rubyTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IncludeState)
    end

    it "Include to idle." do
      @rubyTest.include_capture
      @rubyTest.idle_capture
      expect(@rubyTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
    end

    it "Idle to variable." do
      @rubyTest.variable_capture
      expect(@rubyTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::VariableState)
    end

    it "Variable to idle." do
      @rubyTest.variable_capture
      @rubyTest.idle_capture
      expect(@rubyTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
    end

    it "Idle to function." do
      @rubyTest.function_capture
      expect(@rubyTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::FunctionState)
    end

    it "Function to idle." do
      @rubyTest.function_capture
      @rubyTest.idle_capture
      expect(@rubyTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
    end

    it "Idle to module." do
      @rubyTest.module_capture
      expect(@rubyTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::ModuleState)
    end

    it "Module to idle." do
      @rubyTest.module_capture
      @rubyTest.idle_capture
      expect(@rubyTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
    end

    it "Idle to class." do
      @rubyTest.class_capture
      expect(@rubyTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::ClassState)
    end

    it "Class to idle." do
      @rubyTest.class_capture
      @rubyTest.idle_capture
      expect(@rubyTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
    end

  end

  context "Incorrect Flow" do

    it "Idle to Method." do
      expect{@rubyTest.method_capture}
        .to raise_error(NotImplementedError)
    end

    it "Idle to Attribute" do
      expect{@rubyTest.attribute_capture}
        .to raise_error(NotImplementedError)
    end

    it "Idle to constructor" do
      expect{@rubyTest.constructor_capture}
        .to raise_error(NotImplementedError)
    end

  end

  after :each do
    @rubyTest = nil
  end

end
