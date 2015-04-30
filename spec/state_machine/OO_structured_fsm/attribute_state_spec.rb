require_relative '../../spec_helper.rb'

RSpec.describe StateMachine::OOStructuredFSM::AttributeState do

  before :each do
    @languageState = Languages::RubySyntax.new
  end

  context "#Correct flow." do
    it "Attribute state." do
      @languageState.class_capture
      @languageState.attribute_capture
      expect(@languageState.state)
          .to be_instance_of(StateMachine::OOStructuredFSM::AttributeState) 
    end

    it "Going back to class." do
      @languageState.class_capture
      @languageState.attribute_capture
      expect(@languageState.state)
          .to be_instance_of(StateMachine::OOStructuredFSM::AttributeState)
      @languageState.class_capture
      expect(@languageState.state)
          .to be_instance_of(StateMachine::OOStructuredFSM::ClassState)
    end
  end

  context "#Uncorrect flow." do
    it "From attribute state, try go to invalid state." do
      @languageState.class_capture
      @languageState.attribute_capture
      expect{@languageState.method_capture}
          .to raise_error(NotImplementedError)
      expect{@languageState.function_capture}
          .to raise_error(NotImplementedError)
   end

  end

  after :each do
    @languageState = nil
  end

end
