require_relative 'oo_structured_state'

module StateMachine

  module OOStructuredFSM

    # Class responsible for handling Repetition state.
    class RepetitionState < OOStructuredState

      MAP_STATE = {
        StateMachine::METHOD_STATE => "method",
        StateMachine::CONSTRUCTOR_STATE => "function",
        StateMachine::GLOBAL_FUNCTION_STATE => "constructor"
      }

      @language

      def initialize(pLanguage)
        @language = pLanguage
      end

      def handle_line(pLine)
      end

      # @see OOStructuredState
      def method_capture
        reset_flag
        @language.rewind_state
      end

      # @see OOStructuredState
      def constructor_capture
        reset_flag
        @language.rewind_state
      end

      # @see OOStructuredState
      def function_capture
        reset_flag
        @language.rewind_state
      end

      # @see OOStructuredState
      def execute(pElementFile, pLine)
        repetition = @language.repetitionHandler.get_repetition(pLine)

        flag = @language.flagFunctionBehaviour
        get_add_repetition_lambda(MAP_STATE[flag]).call(repetition, pElementFile)

        has_end_of_block = @language.endBlockHandler.has_end_of_block?(pLine)
        get_capture_lambda(MAP_STATE[flag]).call(has_end_of_block)

        return pElementFile
      end

      private

        # @see OOStructuredState
        def reset_flag
          @language.flagFunctionBehaviour = StateMachine::NONE_HANDLING_STATE
        end

        def get_capture_lambda(lambdaType)
          capture_lambda = lambda do |has_end_of_block|
            self.send("#{lambdaType}_capture") if has_end_of_block
          end

          return capture_lambda
        end

        def get_list_of_file(pElementFile, elementType)
          if elementType == MAP_STATE[StateMachine::CONSTRUCTOR_STATE]
            return pElementFile.global_functions
          else
            return pElementFile.classes.last.send("#{elementType}s")
          end
        end

        def get_add_repetition_lambda(lambdaType)
          add_repetition_lambda = lambda do |repetition, pElementFile|
            element = get_list_of_file(pElementFile, lambdaType).last
            element.add_repetition(repetition) if repetition
          end

          add_repetition_lambda
        end
    # End class
    end

  # End OOStructuredFSM
  end

# End StateMachine
end
