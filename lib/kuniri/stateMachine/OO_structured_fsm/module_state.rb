require_relative '../language/language'

module StateMachine

  module OOStruturedState

    class ModuleState < OOStruturedState

      @language

      def initialize(pLanguage)
        @language = pLanguage
      end

      def idle
        @language.set_state(@language.get_idle_state)
      end

      def class_capture
        @language.set_state(@language.get_class_state)
      end

      def function_capture
        @language.set_state(@language.get_function_state)
      end

    end

  end

end
