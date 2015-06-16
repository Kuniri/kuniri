require_relative 'oo_structured_state.rb'

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
        # TODO: You have to handler the return state.
        # YOU HAVE TO HANDLER OTHER STATES INSIDE FUNCTION.
        if (@previousState.is_a? StateMachine::OOStructuredFSM::ModuleState)
          module_capture
        else
          idle_capture
        end
        return pElementFile
      end

    # End class
    end

  # End OOStructuredFSM
  end

# End StateMachine
end
