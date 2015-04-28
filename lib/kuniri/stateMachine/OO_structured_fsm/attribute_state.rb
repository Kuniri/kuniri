require_relative '../language/language'

module StateMachine

  module OOStruturedState

    class AttributeState < OOStruturedState
      @language

      def initialize(pLanguage)
        @language = pLanguage
      end

      def class_capture
        @language.set_state(@language.get_class_state)
      end

    end

  end

end
