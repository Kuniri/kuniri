require_relative 'oo_structured_state.rb'

module StateMachine

  module OOStructuredFSM

    class ModuleState < OOStructuredState

      @language

      def initialize(pLanguage)
        @language = pLanguage
      end

      def idle
        @language.set_state(@language.idleState)
      end

      def class_capture
        @language.set_state(@language.classState)
      end

      def function_capture
        @language.set_state(@language.functionState)
      end

    # End class
    end

  # End OOStructuredFSM
  end

# End StateMachine
end
