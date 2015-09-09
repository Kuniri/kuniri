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
          variableList.each do |variable|
            variable.comments = @language.string_comment_to_transfer
          end
          @language.string_comment_to_transfer = ""
          pElementFile.add_global_variable(variableList)
        end

        idle_capture
        return pElementFile
      end

    # End class
    end

  # End OOStructuredFSM
  end

# End StateMachine
end
