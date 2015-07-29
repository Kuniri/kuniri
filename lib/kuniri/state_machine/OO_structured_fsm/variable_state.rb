require_relative 'oo_structured_state'

module StateMachine

  module OOStructuredFSM

    # Handling variable state.
    class VariableState < OOStructuredState

      @language

      def initialize(pLanguage)
        @language = pLanguage
      end

      # @see OOStructuredState
      def handle_line(pLine)
        idle_capture
      end

      # @see OOStructuredState
      def idle_capture
        @language.set_state(@language.idleState)
      end

      # @see OOStructuredState
      def execute(pElementFile, pLine)
        variableList = @language.variableHandler.get_variable(pLine)
        if variableList
          pElementFile.add_global_variable(variableList)
        end
        # TODO: You have to handler the return state.
        idle_capture
        return pElementFile
      end

    # End class
    end

  # End OOStructuredFSM
  end

# End StateMachine
end
