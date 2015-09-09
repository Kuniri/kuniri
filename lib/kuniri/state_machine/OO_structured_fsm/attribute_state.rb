require_relative 'oo_structured_state'

module StateMachine

  module OOStructuredFSM

    # Class responsible for handling attribute state.
    class AttributeState < OOStructuredState

      @language

      def initialize(pLanguage)
        @language = pLanguage
      end

      # @see OOStructuredState
      def handle_line(pLine)
      end

      # @see OOStructuredState
      def class_capture
        @language.rewind_state
      end

      # @see OOStructuredState
      def execute(pElementFile, pLine)
        attributeElement = @language.attributeHandler.get_attribute(pLine)

        if attributeElement
          # Add attribute to the last class
          lastIndex = pElementFile.classes.length - 1 # We want the index
          attributeElement.each do |attribute|
            attribute.comments = @language.string_comment_to_transfer
          end
          @language.string_comment_to_transfer = ""
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
