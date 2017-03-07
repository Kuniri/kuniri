require_relative '../../spec_helper'

RSpec.describe StateMachine::OOStructuredFSM::BlockState do

  before :each do
    @blockTest = Languages::RubySyntax.new
  end

  context 'Correct flow, function.' do
    it 'Idle to global function, to block.' do
      @blockTest.state.function_capture
      @blockTest.state.block_capture
      expect(@blockTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::BlockState)
    end

    it 'Block to idle.' do
      @blockTest.state.function_capture
      @blockTest.state.block_capture
      @blockTest.state.function_capture
      expect(@blockTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::FunctionState)
    end
  end

  context 'Correct flow, method.' do
    it 'Idle to class, method, and block.' do
      @blockTest.state.class_capture
      @blockTest.state.method_capture
      @blockTest.state.block_capture
      expect(@blockTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::BlockState)
    end

    it 'Block to idle (method).' do
      @blockTest.state.class_capture
      @blockTest.state.method_capture
      @blockTest.state.block_capture
      @blockTest.state.method_capture
      expect(@blockTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::MethodState)
    end
  end

  context 'Correct flow, constructor.' do
    it 'Idle to constructor, and block.' do
      @blockTest.state.class_capture
      @blockTest.state.constructor_capture
      @blockTest.state.block_capture
      expect(@blockTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::BlockState)
    end

    it 'Costructor to idle (constructor).' do
      @blockTest.state.class_capture
      @blockTest.state.constructor_capture
      @blockTest.state.block_capture
      @blockTest.state.constructor_capture
      expect(@blockTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::ConstructorState)
    end
  end

  context 'Block to block' do
    it 'Self reference to block' do
      @blockTest.state.function_capture
      @blockTest.state.block_capture
      @blockTest.state.block_capture
      @blockTest.state.block_capture
      expect(@blockTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::BlockState)
    end

    it 'Go out of self reference' do
      @blockTest.state.function_capture
      @blockTest.state.block_capture
      @blockTest.state.block_capture
      @blockTest.rewind_state
      expect(@blockTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::BlockState)
      @blockTest.rewind_state
      expect(@blockTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::FunctionState)
    end
  end

  context 'Block to repetition and vice versa' do
    it 'Block to loops' do
      @blockTest.state.function_capture
      @blockTest.state.block_capture
      @blockTest.state.repetition_capture
      expect(@blockTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::RepetitionState)
    end

    it 'Loops to block' do
      @blockTest.state.function_capture
      @blockTest.state.block_capture
      @blockTest.state.repetition_capture
      @blockTest.rewind_state
      expect(@blockTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::BlockState)
    end

    it 'Nested  block ending with repetition' do
      @blockTest.state.function_capture
      @blockTest.state.block_capture
      @blockTest.state.block_capture
      @blockTest.state.repetition_capture
      expect(@blockTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::RepetitionState)
    end

    it 'Nested block ending with repetition, and going back' do
      @blockTest.state.function_capture
      @blockTest.state.block_capture
      @blockTest.state.block_capture
      @blockTest.state.repetition_capture
      @blockTest.state.repetition_capture
      @blockTest.rewind_state
      @blockTest.rewind_state
      expect(@blockTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::BlockState)
    end

  end

  context 'Correct flow: idle to block.' do
    it 'Idle to block.' do
      @blockTest.state.block_capture
      expect(@blockTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::BlockState)
    end

    it 'Block to idle' do
      @blockTest.state.block_capture
      @blockTest.state.idle_capture
      expect(@blockTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
    end

    it 'Idle to conditional, to block' do
      @blockTest.state.conditional_capture
      @blockTest.state.block_capture
      expect(@blockTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::BlockState)
    end

    it 'Idle to repetition, to block' do
      @blockTest.state.repetition_capture
      @blockTest.state.block_capture
      expect(@blockTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::BlockState)
    end

    it 'Idle to repetition, to conditional, to block' do
      @blockTest.state.repetition_capture
      @blockTest.state.conditional_capture
      @blockTest.state.block_capture
      expect(@blockTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::BlockState)
    end

    it 'Idle to repetition, to conditional, to block' do
      @blockTest.state.repetition_capture
      @blockTest.state.conditional_capture
      @blockTest.state.block_capture
      @blockTest.rewind_state
      @blockTest.rewind_state
      @blockTest.rewind_state
      expect(@blockTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
    end

    it 'Idle to block, to repetition, to conditional' do
      @blockTest.state.block_capture
      @blockTest.state.repetition_capture
      @blockTest.state.conditional_capture
      expect(@blockTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::ConditionalState)
    end

    it 'Idle to block, to conditional, to repetition' do
      @blockTest.state.block_capture
      @blockTest.state.conditional_capture
      @blockTest.state.repetition_capture
      expect(@blockTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::RepetitionState)
    end
  end

  context 'Incorrect flow.' do
    it 'Try to access IdleState, to BlockState.' do
      expect{@blockTest.state.block_capture}
        .to raise_error(NotImplementedError)
    end

    it 'Try to jump from block state to idle.' do
      @blockTest.state.class_capture
      @blockTest.state.method_capture
      @blockTest.state.block_capture
      expect{@blockTest.state.class_capture}
        .to raise_error(NotImplementedError)
    end
  end

  after :each do
    @blockTest = nil
  end

end
