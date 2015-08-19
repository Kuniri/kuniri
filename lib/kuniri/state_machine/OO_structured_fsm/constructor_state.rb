require_relative 'oo_structured_state'
require_relative 'method_state'

module StateMachine

  module OOStructuredFSM

    # Class responsible for handling constructor state.
    class ConstructorState < MethodState

      CLASS_TYPE = "constructor"
      METHOD_TYPE = "constructor"

      def initialize(pLanguage)
        super(
          pLanguage,
          state: StateMachine::CONSTRUCTOR_STATE,
          classType: ConstructorState::CLASS_TYPE,
          methodType: ConstructorState::METHOD_TYPE
        )
      end

    # End class
    end

  # End OOStructuredFSM
  end

# End StateMachine
end
