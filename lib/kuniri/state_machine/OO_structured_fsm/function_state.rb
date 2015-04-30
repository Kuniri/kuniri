require_relative 'oo_structured_state.rb'

module StateMachine

  module OOStructuredFSM

    class FunctionState < OOStructuredState

      @language

      def initialize(pLanguage)
        @language = pLanguage
      end

      def idle_capture
        @language.set_state(@language.idleState)
      end

      def module_capture
        @language.set_state(@language.moduleState)
      end

    # End class
    end

  # End OOStructuredFSM
  end

# End StateMachine
end
