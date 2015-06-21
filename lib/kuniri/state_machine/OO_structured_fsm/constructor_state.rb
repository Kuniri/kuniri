require_relative 'oo_structured_state.rb'

module StateMachine

  module OOStructuredFSM

    class ConstructorState < OOStructuredState

      @language

      def initialize(pLanguage)
        @language = pLanguage
      end

      def class_capture
        @language.rewind_state
      end
    
    # End class
    end

  # End OOStructuredFSM
  end

# End StateMachine
end
