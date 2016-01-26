require_relative '../../spec_helper'

RSpec.describe StateMachine::OOStructuredFSM::IncludeState do

  before :each do
    @rubyTest = Languages::RubySyntax.new
  end

  context "Correct flow." do

    it "Idle to Include" do
      @rubyTest.state.include_capture
      expect(@rubyTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IncludeState)
    end

    it "Include to idle" do
      @rubyTest.state.include_capture
      @rubyTest.idle_capture
      expect(@rubyTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
    end

  end

  context "Incorrect flow." do

    it "Include to variable" do
      @rubyTest.state.include_capture
      expect{@rubyTest.variable_capture}
        .to raise_error(NotImplementedError)
    end

  end

  context "Correct flow, and correct data extration." do

    it "Include state, and capture require." do
      @rubyTest.state.include_capture
      fileElement = Languages::FileElementData.new("test_spec")
      @rubyTest.state.execute(fileElement, "require_relative 'test_file.rb'")
      expect(@rubyTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
    end

    it "Include state, and returned value" do
      @rubyTest.state.include_capture
      fileElement = Languages::FileElementData.new("test_spec")
      fileElement = @rubyTest.state.execute(fileElement,
                                            "require_relative 'test.rb'")
      expect(fileElement.extern_requirements[0].library).to eq ("test")
      expect(@rubyTest.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
    end

  end

  after :each do
    @rubyTest = nil
  end

end
