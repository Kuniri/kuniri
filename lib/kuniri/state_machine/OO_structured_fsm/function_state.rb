require_relative 'oo_structured_state'
require_relative 'module_state'
require_relative 'token_state_machine'

module StateMachine

  module OOStructuredFSM

    # Class responsible for handling function state.
    class FunctionState < OOStructuredState

      @language

      def initialize(pLanguage)
        @language = pLanguage
      end

      # @see OOStructuredState
      def handle_line(pLine)
        if @language.line_inspect(CONDITIONAL_ID, pLine)
          conditional_capture
        elsif @language.line_inspect(REPETITION_ID, pLine)
          repetition_capture
        elsif @language.line_inspect(BLOCK_ID, pLine)
          block_capture
        else
          return
        end
      end

      # @see OOStructuredState
      def idle_capture
        @language.rewind_state
      end

      # @see OOStructuredState
      def module_capture
        @language.rewind_state
      end

      # @see OOStructuredState
      def conditional_capture
        @language.flagFunctionBehaviour = StateMachine::GLOBAL_FUNCTION_STATE
        @language.set_state(@language.conditionalState)
      end

      # @see OOStructuredState
      def repetition_capture
        @language.flagFunctionBehaviour = StateMachine::GLOBAL_FUNCTION_STATE
        @language.set_state(@language.repetitionState)
      end

      # @see OOStructuredState
      def block_capture
        @language.flagFunctionBehaviour = StateMachine::GLOBAL_FUNCTION_STATE
        @language.set_state(@language.blockState)
      end

      # @see OOStructuredState
      def execute(pElementFile, pLine)
        function = @language.line_inspect(FUNCTION_ID, pLine)

        if function
          function.comments = @language.string_comment_to_transfer
          @language.string_comment_to_transfer = ''
          pElementFile.add_global_function(function)
        end

        if (@language.endBlockHandler.has_end_of_block?(pLine))
          previous = @language.previousState.last

          if (previous.is_a? (StateMachine::OOStructuredFSM::ModuleState))
            module_capture
          elsif (previous.is_a? (StateMachine::OOStructuredFSM::IdleState))
            idle_capture
          end

        end

        return pElementFile
      end

    # End class
    end

  # End OOStructuredFSM
  end

# End StateMachine
end
