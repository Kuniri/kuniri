require_relative '../language/language'

module OOStruturedState

  module OOStructuredFSM

    class ConstructorState < OOStruturedState

      @language

      def initialize(pLanguage)
        @language = pLanguage
      end

      def constructor_capture
        @language.set_state(@language.get_class_state)
      end
      
    end

  end

end
