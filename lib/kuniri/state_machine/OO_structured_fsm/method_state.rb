require_relative 'oo_structured_state'

module StateMachine

  module OOStructuredFSM

    # Class responsible for handling Method state.
    class MethodState < OOStructuredState

      @language

      def initialize(pLanguage)
        @language = pLanguage
      end

      # @see OOStructuredState
      def handle_line(pLine)
        if @language.conditionalHandler.get_conditional(pLine)
          conditional_capture
        elsif @language.repetitionHandler.get_repetition(pLine)
          repetition_capture
        else
          return
        end
      end

      # @see OOStructuredState
      def class_capture
        @language.rewind_state
      end

      # @see OOStructuredState
      def conditional_capture
        @language.flagFunctionBehaviour = StateMachine::METHOD_STATE
        @language.set_state(@language.conditionalState)
      end

      # @see OOStructuredState
      def repetition_capture
        @language.flagFunctionBehaviour = StateMachine::METHOD_STATE
        @language.set_state(@language.repetitionState)
      end

      # @see OOStructuredState
      def execute(pElementFile, pLine)
        methodElement = @language.methodHandler.get_function(pLine)

        if (methodElement)
          lastIndex = pElementFile.classes.length - 1 # We want the index
          methodElement.comments = @language.string_comment_to_transfer
          @language.string_comment_to_transfer = ""
          pElementFile.classes[lastIndex].add_method(methodElement)
        end

        if (@language.endBlockHandler.has_end_of_block?(pLine))
          class_capture
        end

        return pElementFile
      end

    # End class
    end

  # End OOStructuredFSM
  end

# End StateMachine
end
