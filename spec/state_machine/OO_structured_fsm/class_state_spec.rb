require_relative '../../spec_helper'

RSpec.describe StateMachine::OOStructuredFSM::AttributeState do

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
  end

  after :each do
    @classStateTest = nil
  end

end
