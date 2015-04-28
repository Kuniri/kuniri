require_relative '../language/language'

module StateMachine

  module OOStruturedState

    class MethodState < OOStruturedState
      @language

      def initialize(pLanguage)
        @language = pLanguage
      end

      def method_capture
        @language.set_state(@language.get_class_state)
      end

    end

  end

end
