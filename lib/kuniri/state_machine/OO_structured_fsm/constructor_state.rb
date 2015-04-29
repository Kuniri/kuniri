require_relative 'oo_structured_state.rb'

module StateMachine

  module OOStructuredFSM

    class ConstructorState < OOStructuredState

      @language

      def initialize(pLanguage)
        @language = pLanguage
      end

      def constructor_capture
        @language.set_state(@language.get_class_state)
      end
    
    # End class
    end

  # End OOStructuredFSM
  end

# End StateMachine
end
