require_relative '../../spec_helper'

RSpec.describe StateMachine::OOStructuredFSM::ConditionalState do

  before :each do
    @conditionalTest = Languages::RubySyntax.new
  end

  context "Correct flow, function." do
    it "Idle to global function, to conditional." do
      @conditionalTest.state.function_capture
      @conditionalTest.state.conditional_capture
      expect(@conditionalTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::ConditionalState)
    end

    it "Conditional to idle." do
      @conditionalTest.state.function_capture
      @conditionalTest.state.conditional_capture
      @conditionalTest.state.function_capture
      expect(@conditionalTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::FunctionState)
    end
  end

  context "Correct flow, method." do
    it "Idle to class, method, and conditional." do
      @conditionalTest.state.class_capture
      @conditionalTest.state.method_capture
      @conditionalTest.state.conditional_capture
      expect(@conditionalTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::ConditionalState)
    end

    it "Conditional to idle (method)." do
      @conditionalTest.state.class_capture
      @conditionalTest.state.method_capture
      @conditionalTest.state.conditional_capture
      @conditionalTest.state.method_capture
      expect(@conditionalTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::MethodState)
    end
  end

  context "Correct flow, constructor." do
    it "Idle to constructor, and conditional." do
      @conditionalTest.state.class_capture
      @conditionalTest.state.constructor_capture
      @conditionalTest.state.conditional_capture
      expect(@conditionalTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::ConditionalState)
    end

    it "Conditional to idle (constructor)." do
      @conditionalTest.state.class_capture
      @conditionalTest.state.constructor_capture
      @conditionalTest.state.conditional_capture
      @conditionalTest.state.constructor_capture
      expect(@conditionalTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::ConstructorState)
    end
  end

  context "Incorrect flow." do
    it "Try to access IdleState, to ConditionalState." do
      expect{@conditionalTest.state.conditional_capture}
        .to raise_error(NotImplementedError)
    end

    it "Try to jump from Conditional state to idle." do
      @conditionalTest.state.class_capture
      @conditionalTest.state.method_capture
      @conditionalTest.state.conditional_capture
      expect{@conditionalTest.state.class_capture}
        .to raise_error(NotImplementedError)
    end
  end

  after :each do
    @constructorTest = nil
  end

end
