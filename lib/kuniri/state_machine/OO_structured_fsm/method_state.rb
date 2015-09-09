require_relative 'oo_structured_state'
require_relative 'token_state_machine'

module StateMachine

  module OOStructuredFSM

    # Class responsible for handling Method state.
    class MethodState < OOStructuredState

      CLASS_TYPE = StateMachine::METHOD_LABEL
      METHOD_TYPE = StateMachine::FUNCTION_LABEL

      @language

      @state
      @classType
      @methodType

      def initialize(pLanguage, params = {})
        @language = pLanguage

        @state = params[:state] || StateMachine::METHOD_STATE
        @classType = params[:classType] || MethodState::CLASS_TYPE
        @methodType = params[:methodType] || MethodState::METHOD_TYPE
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
        @language.flagFunctionBehaviour = @state
        @language.set_state(@language.conditionalState)
      end

      # @see OOStructuredState
      def repetition_capture
        @language.flagFunctionBehaviour = @state
        @language.set_state(@language.repetitionState)
      end

      # @see OOStructuredState
      def execute(pElementFile, pLine)
        methodElement = @language.send("#{@classType}Handler").send("get_#{@methodType}", pLine)

        if (methodElement)
          lastIndex = pElementFile.classes.length - 1 # We want the index
          methodElement.comments = @language.string_comment_to_transfer
          @language.string_comment_to_transfer = ""
          pElementFile.classes[lastIndex].send("add_#{@classType}", methodElement)
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
