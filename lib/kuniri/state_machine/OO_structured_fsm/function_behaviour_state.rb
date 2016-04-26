require_relative 'oo_structured_state'
require_relative 'token_state_machine'

module StateMachine

  module OOStructuredFSM

    # Class responsible for handling Method and constructor state.
    class FunctionBehaviourState < OOStructuredState

      @language
      @flagState
      @functionIdentifier

      # Constructor responsible for setup the basic configuration.
      # @param pLanguage Reference to language object.
      # @param pParams Dictionary with all element data.
      def initialize(pLanguage, pParams = {})
        @language = pLanguage
        @flagState = pParams[:flagState] || StateMachine::METHOD_STATE
        @functionIdentifier = pParams[:functionId] || MethodState::METHOD_LABEL
      end

      # @see OOStructuredState
      def handle_line(pLine)
        if @language.conditionalHandler.get_conditional(pLine)
          conditional_capture
        elsif @language.repetitionHandler.get_repetition(pLine)
          repetition_capture
        elsif @language.aggregationHandler.get_aggregation(pLine)
          aggregation_capture
        elsif @language.blockHandler.get_block(pLine)
          block_capture
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
        @language.flagFunctionBehaviour = @flagState
        @language.set_state(@language.conditionalState)
      end

      # @see OOStructuredState
      def repetition_capture
        @language.flagFunctionBehaviour = @flagState
        @language.set_state(@language.repetitionState)
      end

      # @see OOStructuredState
      def block_capture
        @language.flagFunctionBehaviour = @flagState
        @language.set_state(@language.blockState)
      end

      # @see OOStructuredState
      def aggregation_capture
        @language.set_state(@language.aggregationState)
      end

      # @see OOStructuredState
      def execute(pElementFile, pLine)
        functionElement = @language.send("#{@functionIdentifier}Handler")
                                   .send("get_#{@functionIdentifier}", pLine)

        if (functionElement)
          lastIndex = pElementFile.classes.length - 1 # We want the index
          functionElement.comments = @language.string_comment_to_transfer
          @language.string_comment_to_transfer = ""
          pElementFile.classes[lastIndex].send("add_#{@functionIdentifier}",
                                               functionElement)
        end

        if (@language.endBlockHandler.has_end_of_block?(pLine))
          @language.rewind_state
        end

        return pElementFile
      end

    # End class
    end

  # End OOStructuredFSM
  end

# End StateMachine
end
