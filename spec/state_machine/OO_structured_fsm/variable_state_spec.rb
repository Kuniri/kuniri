require_relative '../../spec_helper'

RSpec.describe StateMachine::OOStructuredFSM::VariableState do

  before :each do
    @rubyTest = Languages::RubySyntax.new
  end

  context "Correct flow." do

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

  end

  context "Incorrect flow." do

    it "Variable to module." do
      @rubyTest.variable_capture
      expect{@rubyTest.module_capture}
        .to raise_error(NotImplementedError)
    end

  end

  after :all do
    @rubyTest = nil
  end

end
