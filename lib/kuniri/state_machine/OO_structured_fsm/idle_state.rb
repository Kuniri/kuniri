require_relative 'oo_structured_state.rb'

module StateMachine

  module OOStructuredFSM

    class IdleState < OOStructuredState

      @language

      def initialize(pLanguage)
        @language = pLanguage
      end

      def include_capture
        @language.set_state(@language.includeState)
      end

      def variable_capture
        @language.set_state(@language.variableState)
      end

      def function_capture
        @language.set_state(@language.functionState)
      end

      def module_capture
        @language.set_state(@language.moduleState)
      end

      def class_capture
        @language.set_state(@language.classState)
      end

    # End class
    end

  # End OOStructuredFSM
  end

# End StateMachine
end
