require_relative '../../spec_helper'

RSpec.describe StateMachine::OOStructuredFSM::IncludeState do

  before :each do
    @rubyTest = Languages::RubySyntax.new
  end

  context "Correct flow." do

    it "Idle to Include" do
      @rubyTest.include_capture
      expect(@rubyTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IncludeState)
    end

    it "Include to idle" do
      @rubyTest.include_capture
      @rubyTest.idle_capture
      expect(@rubyTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
    end

  end

  context "Incorrect flow." do

    it "Include to variable" do
      @rubyTest.include_capture
      expect{@rubyTest.variable_capture}
        .to raise_error(NotImplementedError)
    end

  end

  after :each do
    @rubyTest = nil
  end

end
