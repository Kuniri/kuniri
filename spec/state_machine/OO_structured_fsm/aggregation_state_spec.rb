require_relative '../../spec_helper.rb'

RSpec.describe StateMachine::OOStructuredFSM::AggregationState do

  before :each do
    @languageState = Languages::RubySyntax.new
  end

  context "#Correct flow." do
    it "Aggregation state from class." do
      @languageState.class_capture
      @languageState.aggregation_capture
      expect(@languageState.state)
          .to be_instance_of(StateMachine::OOStructuredFSM::AggregationState) 
    end

    it "Going back to class." do
      @languageState.class_capture
      @languageState.aggregation_capture
      expect(@languageState.state)
          .to be_instance_of(StateMachine::OOStructuredFSM::AggregationState)
      @languageState.class_capture
      expect(@languageState.state)
          .to be_instance_of(StateMachine::OOStructuredFSM::ClassState)
    end

    it "Aggregation state from method." do
      @languageState.class_capture
      @languageState.method_capture
      @languageState.aggregation_capture
      expect(@languageState.state)
          .to be_instance_of(StateMachine::OOStructuredFSM::AggregationState)
      @languageState.class_capture
      expect(@languageState.state)
          .to be_instance_of(StateMachine::OOStructuredFSM::MethodState)
    end

    it "Aggregation state from constructor." do
      @languageState.class_capture
      @languageState.constructor_capture
      @languageState.aggregation_capture
      expect(@languageState.state)
          .to be_instance_of(StateMachine::OOStructuredFSM::AggregationState)
      @languageState.class_capture
      expect(@languageState.state)
          .to be_instance_of(StateMachine::OOStructuredFSM::ConstructorState)
    end

  end

  context "#Uncorrect flow." do
    it "From aggregation state, try go to invalid state." do
      @languageState.class_capture
      @languageState.aggregation_capture
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
