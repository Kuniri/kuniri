require_relative 'oo_structured_state.rb'

module StateMachine

  module OOStructuredFSM

    # Handling variable state.
    class VariableState < OOStructuredState

      @language

      def initialize(pLanguage)
        @language = pLanguage
      end

      def idle
        @language.set_state(@language.idleState)
      end

    # End class
    end

  # End OOStructuredFSM
  end

# End StateMachine
end
