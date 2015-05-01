require_relative '../../spec_helper'

RSpec.describe StateMachine::OOStructuredFSM::MethodState do

  before :each do
    @rubyTest = Languages::RubySyntax.new
  end

  context "Correct flow." do

    it "Idle to method" do
      @rubyTest.class_capture
      @rubyTest.method_capture
      expect(@rubyTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::MethodState)
    end

    it "Method to class" do
      @rubyTest.class_capture
      @rubyTest.method_capture
      @rubyTest.class_capture
      expect(@rubyTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::ClassState)
    end

  end

  context "Incorrect flow." do

    it "Method to idle" do
      @rubyTest.class_capture
      @rubyTest.method_capture
      expect{@rubyTest.idle_capture}
    end

  end

  after :each do
    @rubyTest = nil
  end

end
