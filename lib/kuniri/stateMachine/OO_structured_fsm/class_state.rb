require_relative '../language/language'

module OOStruturedState

  module OOStructuredFSM

    class ClassState < OOStruturedState

      @language

      def initialize (pLanguage)
        @language = pLanguage
      end

      def method_capture
        @language.set_state(@language.get_method_state)
      end

      def constructor_capture
        @language.set_state(@language.get_constructor_state)
      end

      def attribute_capture
        @language.set_state(@language.get_attribute_state)
      end

      def module_capture
        @language.set_state(@language.get_module_state)
      end

      def idle
        @language.set_state(@language.get_idle_state)
      end 

    end

  end

end
