require_relative 'oo_structured_state'
require_relative 'token_state_machine'

module StateMachine

  module OOStructuredFSM

    # Class responsible for handling Method state.
    class MethodState < FunctionBehaviourState

      def initialize(pLanguage)
        super(
          pLanguage,
          flagState: StateMachine::METHOD_STATE,
          functionId: StateMachine::METHOD_LABEL
        )
      end

    # End class
    end

  # End OOStructuredFSM
  end

# End StateMachine
end
