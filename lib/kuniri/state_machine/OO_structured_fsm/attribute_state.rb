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
          lastIndex = pElementFile.classes.length - 1 # We want the index
          pElementFile.classes[lastIndex].add_attribute(attributeElement)
        end

        class_capture
        return pElementFile
      end

    # End class
    end

  # End OOStructuredFSM
  end

# End StateMachine
end
