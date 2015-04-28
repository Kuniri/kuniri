require_relative '../language/language'

module StateMachine

  module OOStructuredFSM

    # Handling variable state.
    class VariableState < OOStruturedState

      @language

      def initialize(pLanguage)
        @language = pLanguage
      end

      def idle
        @language.set_state(@language.get_idle_state())
      end

    end

  end

end
