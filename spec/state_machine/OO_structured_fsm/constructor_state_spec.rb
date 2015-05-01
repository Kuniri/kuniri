require_relative '../../spec_helper'

RSpec.describe StateMachine::OOStructuredFSM::ConstructorState do

  before :each do
    @constructorTest = Languages::RubySyntax.new
  end

  context "Correct flow." do
    it "Idle to constructor." do
      @constructorTest.class_capture
      @constructorTest.constructor_capture
      expect(@constructorTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::ConstructorState)
    end

    it "Constructor to class." do
      @constructorTest.class_capture
      @constructorTest.constructor_capture
      @constructorTest.class_capture
      expect(@constructorTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::ClassState)
    end

    it "Constructor to idle." do
      @constructorTest.class_capture
      @constructorTest.constructor_capture
      @constructorTest.class_capture
      @constructorTest.idle_capture
      expect(@constructorTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
    end
  end

  context "Incorrect flow." do
    it "Try to access IdleState, from ConstructorState." do
      @constructorTest.class_capture
      @constructorTest.constructor_capture
      expect{@constructorTest.idle_capture}
        .to raise_error(NotImplementedError)
    end
  end

  after :each do
    @constructorTest = nil
  end

end
