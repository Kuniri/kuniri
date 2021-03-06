#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

require_relative 'oo_structured_state'

module StateMachine

  module OOStructuredFSM

    # Class responsible for handling class state.
    class ClassState < OOStructuredState
      def initialize(pLanguage)
        @language = pLanguage
      end

      # @see OOStructuredState
      def handle_line(pLine)
        elements = {
          AGGREGATION_ID => method(:aggregation_capture),
          ATTRIBUTE_ID => method(:attribute_capture),
          CONSTRUCTOR_ID => method(:constructor_capture),
          METHOD_ID => method(:method_capture),
          MODULE_ID => method(:module_capture)
        }

        elements.each do |id, function|
          return function.call if @language.line_inspect(id, pLine)
        end

        if @language.commentHandler.single_line_comment?(pLine) ||
           @language.commentHandler.multiple_line_comment?(pLine)
          comment_capture
        end

        return
      end

      # @see OOStructuredState
      def method_capture
        @language.set_state(@language.methodState)
      end

      # @see OOStructuredState
      def constructor_capture
        @language.set_state(@language.constructorState)
      end

      # @see OOStructuredState
      def attribute_capture
        @language.set_state(@language.attributeState)
      end

      # @see OOStructuredState
      def module_capture
        @language.rewind_state
      end

      # @see OOStructuredState
      def idle_capture
        @language.rewind_state
      end

      # @see OOStructuredState
      def comment_capture
        @language.set_state(@language.commentState)
      end

      def aggregation_capture
        @language.set_state(@language.aggregationState)
      end

      # @see OOStructuredState
      def execute(pElementFile, pLine)
        classElement = @language.processed_line

        if classElement
          classElement.comments = @language.string_comment_to_transfer
          @language.string_comment_to_transfer = ''
          pElementFile.add_class(classElement)
          @language.metadata.allClasses.push(classElement)
        end

        if @language.endBlockHandler.end_of_block?(pLine)
          previous = @language.previousState.last

          if (previous.is_a? StateMachine::OOStructuredFSM::IdleState)
            idle_capture
          elsif (previous.is_a? StateMachine::OOStructuredFSM::ModuleState)
            module_capture
          else
            return pElementFile
          end
        end

        return pElementFile
      end
    end # End class
  end # End OOStructuredFSM
end # End module
