require_relative '../../spec_helper'

RSpec.describe StateMachine::OOStructuredFSM::RepetitionState do

  before :each do
    @repetitionTest = Languages::RubySyntax.new
  end

  context "Correct flow, function." do
    it "Idle to global function, to repetition." do
      @repetitionTest.state.function_capture
      @repetitionTest.state.repetition_capture
      expect(@repetitionTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::RepetitionState)
    end

    it "Repetition to idle." do
      @repetitionTest.state.function_capture
      @repetitionTest.state.repetition_capture
      @repetitionTest.state.function_capture
      expect(@repetitionTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::FunctionState)
    end
  end

  context "Correct flow, method." do
    it "Idle to class, method, and repetition." do
      @repetitionTest.state.class_capture
      @repetitionTest.state.method_capture
      @repetitionTest.state.repetition_capture
      expect(@repetitionTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::RepetitionState)
    end

    it "Conditional to idle (method)." do
      @repetitionTest.state.class_capture
      @repetitionTest.state.method_capture
      @repetitionTest.state.repetition_capture
      @repetitionTest.state.method_capture
      expect(@repetitionTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::MethodState)
    end
  end

  context "Correct flow, constructor." do
    it "Idle to constructor, and repetition." do
      @repetitionTest.state.class_capture
      @repetitionTest.state.constructor_capture
      @repetitionTest.state.repetition_capture
      expect(@repetitionTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::RepetitionState)
    end

    it "Repetition to idle (constructor)." do
      @repetitionTest.state.class_capture
      @repetitionTest.state.constructor_capture
      @repetitionTest.state.repetition_capture
      @repetitionTest.state.constructor_capture
      expect(@repetitionTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::ConstructorState)
    end
  end

  context "Incorrect flow." do
    it "Try to access IdleState, to ConditionalState." do
      expect{@repetitionTest.state.repetition_capture}
        .to raise_error(NotImplementedError)
    end

    it "Try to jump from Conditional state to idle." do
      @repetitionTest.state.class_capture
      @repetitionTest.state.method_capture
      @repetitionTest.state.repetition_capture
      expect{@repetitionTest.state.class_capture}
        .to raise_error(NotImplementedError)
    end
  end

  after :each do
    @constructorTest = nil
  end

end
