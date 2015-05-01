require_relative '../../spec_helper'

RSpec.describe StateMachine::OOStructuredFSM::ClassState do

  before :each do
    @classStateTest = Languages::RubySyntax.new
  end

  context "Class state, correct flow." do
    it "Idle to class." do
      @classStateTest.class_capture
      expect(@classStateTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::ClassState)
    end

    it "Class to idle." do
      @classStateTest.class_capture
      @classStateTest.idle_capture
      expect(@classStateTest.state)
          .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
    end

    it "Class to method." do
      @classStateTest.class_capture
      @classStateTest.method_capture
      expect(@classStateTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::MethodState)
    end

    it "Method to class." do
      @classStateTest.class_capture
      @classStateTest.method_capture
      @classStateTest.class_capture
      expect(@classStateTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::ClassState)
    end

    it "Class to attribute." do
      @classStateTest.class_capture
      @classStateTest.attribute_capture
      expect(@classStateTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::AttributeState)
    end

    it "Attribute to class." do
      @classStateTest.class_capture
      @classStateTest.attribute_capture
      @classStateTest.class_capture
      expect(@classStateTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::ClassState)
    end

    it "Class to constructor." do
      @classStateTest.class_capture
      @classStateTest.constructor_capture
      expect(@classStateTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::ConstructorState)
    end

    it "Constructor to class." do
      @classStateTest.class_capture
      @classStateTest.constructor_capture
      @classStateTest.class_capture
      expect(@classStateTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::ClassState)
    end

    it "Class to module" do
      @classStateTest.class_capture
      @classStateTest.module_capture
      expect(@classStateTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::ModuleState)
    end

    it "Module to class" do
      @classStateTest.class_capture
      @classStateTest.module_capture
      @classStateTest.class_capture
      expect(@classStateTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::ClassState)
    end 

  end

  context "Wrong state, incorrect flow." do
    it "Wrong state change." do
      @classStateTest.class_capture
      expect{@classStateTest.variable_capture}
        .to raise_error(NotImplementedError)
    end
  end

  after :each do
    @classStateTest = nil
  end

end
