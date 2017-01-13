#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

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
        attributeElement = @language.processed_line

        if attributeElement
          # Add attribute to the last class
          attributeElement.each do |attribute|
            attribute.comments = @language.string_comment_to_transfer
          end
          @language.string_comment_to_transfer = ''
          pElementFile.add_attribute_to_last_class(attributeElement)
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
