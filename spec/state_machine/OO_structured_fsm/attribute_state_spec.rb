require_relative '../../spec_helper.rb'

RSpec.describe StateMachine::OOStructuredFSM::AttributeState do

  before :each do
    @languageState = Languages::RubySyntax.new
  end

  context "#Correct state" do
    it "Go to attribute state" do
      @languageState.set_state(@languageState.classState)
      @languageState.set_state(@languageState.attributeState)
      expect(@languageState.state).to be_instance_of(StateMachine::OOStructuredFSM::AttributeState) 
    end
  end

  after :each do
    @languageState = nil
  end

end
