require_relative '../../spec_helper'

RSpec.describe StateMachine::OOStructuredFSM::CommentState do

  before :each do
    @rubyTest = Languages::RubySyntax.new
  end

  context "Correct flow" do

    it "Idle to comment." do
      @rubyTest.state.comment_capture
      expect(@rubyTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::CommentState)
    end

    it "Class to comment." do
      @rubyTest.state.class_capture
      @rubyTest.state.comment_capture
      expect(@rubyTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::CommentState)
    end

  end

  after :each do
    @rubyTest = nil
  end

end
