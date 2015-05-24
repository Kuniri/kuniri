require_relative 'oo_structured_state.rb'

module StateMachine

  module OOStructuredFSM

    class ModuleState < OOStructuredState

      @language

      def initialize(pLanguage)
        @language = pLanguage
      end

      def handle_line(pLine)
        if @language.idleHandler.get_idle(pLine)
          idle_capture
        elsif @language.classHandler.get_class(pLine)
          class_capture
        elsif @language.functionHandler.get_function(pLine)
          function_capture
        end
      end

      def idle_capture
        @language.set_state(@language.idleState)
      end

      def class_capture
        @language.set_state(@language.classState)
      end

      def function_capture
        @language.set_state(@language.functionState)
      end

    # End class
    end

  # End OOStructuredFSM
  end

# End StateMachine
end
