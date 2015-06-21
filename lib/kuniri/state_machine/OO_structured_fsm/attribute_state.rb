require_relative 'oo_structured_state.rb'

module StateMachine

  module OOStructuredFSM

    class AttributeState < OOStructuredState

      @language

      def initialize(pLanguage)
        @language = pLanguage
      end

      def handle_line(pLine)
          # TODO: YOU HAVE TO HANDLER THE CASE OF SELF REFERENCE
      end

      def class_capture
        @language.rewind_state
      end

      def execute(pElementFile, pLine)
        attributeElement = @language.attributeHandler.get_attribute(pLine)

        if attributeElement
          # Add attribute to the last class
          lastElement = pElementFile.classes.leght
          pElementFile.classes[lastElement].add_attribute(attributeElement)
        end

        if (@language.previousState.is_a? (
            StateMachine::OOStructuredFSM::ClassState))
          class_capture
        end

      end

    # End class
    end

  # End OOStructuredFSM
  end

# End StateMachine
end
