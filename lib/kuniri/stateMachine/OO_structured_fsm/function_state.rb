require_relative '../language/language'

module StateMachine

  module OOStruturedState

    class FunctionState < OOStruturedState

      @language

      def initialize(pLanguage)
        @language = pLanguage
      end

      def idle
        @language.set_state(@language.get_idle_state)
      end

      def module_capture
        @language.set_state(@language.get_module_state)
      end

    end

  end

end
