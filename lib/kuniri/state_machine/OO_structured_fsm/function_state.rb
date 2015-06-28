require_relative 'oo_structured_state'
require_relative 'module_state'
require_relative 'token_state_machine'

module StateMachine

  module OOStructuredFSM

    class FunctionState < OOStructuredState

      @language

      def initialize(pLanguage)
        @language = pLanguage
      end

      def handle_line(pLine)
        if @language.conditionalHandler.get_conditional(pLine)
          conditional_capture
        else
          return
        end
      end

      def idle_capture
        @language.rewind_state
      end

      def module_capture
        @language.rewind_state
      end

      def conditional_capture
        @language.flagFunctionBehaviour = StateMachine::GLOBAL_FUNCTION_STATE
        @language.set_state(@language.conditionalState)
      end

      def execute(pElementFile, pLine)
        function = @language.functionHandler.get_function(pLine)

        if function
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
