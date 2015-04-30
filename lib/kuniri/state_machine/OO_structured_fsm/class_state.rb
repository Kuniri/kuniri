require_relative 'oo_structured_state.rb'

module StateMachine

  module OOStructuredFSM

    class ClassState < OOStructuredState

      @language

      def initialize (pLanguage)
        @language = pLanguage
      end

      def method_capture
        @language.set_state(@language.methodState)
      end

      def constructor_capture
        @language.set_state(@language.constructorState)
      end

      def attribute_capture
        @language.set_state(@language.attributeState)
      end

      def module_capture
        @language.set_state(@language.moduleState)
      end

      def idle_capture
        @language.set_state(@language.idleState)
      end 

    # End class
    end

  # End OOStructuredFSM
  end

# 
end
