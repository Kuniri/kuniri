require_relative 'oo_structured_state.rb'

module StateMachine

  module OOStructuredFSM

    class MethodState < OOStructuredState

      @language

      def initialize(pLanguage)
        @language = pLanguage
      end

      def handle_line(pLine)
        if @language.classHandler.get_class(pLine)
          class_capture
        end
      end

      def class_capture
        @language.set_state(@language.classState)
      end

    # End class
    end

  # End OOStructuredFSM
  end

# End StateMachine
end
