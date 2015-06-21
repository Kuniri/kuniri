require_relative 'oo_structured_state'
require_relative 'module_state'

module StateMachine

  module OOStructuredFSM

    class FunctionState < OOStructuredState

      @language

      def initialize(pLanguage)
        @language = pLanguage
      end

      def handle_line(pLine)
        # TODO: Handle it!
        # idle_capture
        # Conditionals, repetitions
      end

      def idle_capture
        @language.set_state(@language.idleState)
      end

      def module_capture
        @language.set_state(@language.moduleState)
      end

      def execute(pElementFile, pLine)
        function = @language.functionHandler.get_function(pLine)

        if function
         pElementFile.add_global_function(function)
        end

        previous = @language.previousState.last

        if (previous.is_a? (StateMachine::OOStructuredFSM::ModuleState))
          module_capture
        elsif (previous.is_a? (StateMachine::OOStructuredFSM::IdleState))
          idle_capture
        else
          return 
        end

        @language.rewind_state

        return pElementFile
      end

    # End class
    end

  # End OOStructuredFSM
  end

# End StateMachine
end
