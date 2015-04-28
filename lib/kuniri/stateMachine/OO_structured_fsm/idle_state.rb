require_relative '../language/language'

module StateMachine

  module OOStruturedState

    class IdleState

      @language

      def initialize(pLanguage)
        @language = pLanguage
      end

      def include_capture
        @language.set_state(@language.get_include_state)
      end

      def variable_capture
        @language.set_state(@language.get_variable_state)
      end

      def function_capture
        @language.set_state(@language.get_function_state)
      end

      def module_capture
        @language.set_state(@language.get_module_state)
      end

      def class_capture
        @language.set_state(@language.get_class_state)
      end

    end

  end

end
