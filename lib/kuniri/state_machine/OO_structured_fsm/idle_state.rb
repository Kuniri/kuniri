#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

require_relative 'oo_structured_state'

module StateMachine

  module OOStructuredFSM

    # Class responsible for handling Idle state.
    class IdleState < OOStructuredState

      @language

      def initialize(pLanguage)
        @language = pLanguage
      end

      # @see OOStructuredState
      def handle_line(pLine)
        if @language.line_inspect(EXTERN_REQUIREMENT_ID, pLine)
          include_capture
        elsif @language.line_inspect(VARIABLE_ID, pLine)
          variable_capture
        elsif @language.line_inspect(FUNCTION_ID, pLine)
          function_capture
        elsif @language.line_inspect(MODULE_ID, pLine)
          module_capture
        elsif @language.line_inspect(CLASS_ID, pLine)
          class_capture
        elsif @language.line_inspect(CONDITIONAL_ID, pLine)
          conditional_capture
        elsif @language.line_inspect(REPETITION_ID, pLine)
          repetition_capture
        elsif ((@language.commentHandler.single_line_comment?(pLine)) ||
                (@language.commentHandler.multiple_line_comment?(pLine)))
          comment_capture
        else
          return
        end
      end

      # @see OOStructuredState
      def include_capture
        @language.set_state(@language.includeState)
      end

      # @see OOStructuredState
      def variable_capture
        @language.set_state(@language.variableState)
      end

      # @see OOStructuredState
      def function_capture
        @language.set_state(@language.functionState)
      end

      # @see OOStructuredState
      def module_capture
        @language.set_state(@language.moduleState)
      end

      # @see OOStructuredState
      def class_capture
        @language.set_state(@language.classState)
      end

      # @see OOStructuredState
      def comment_capture
        @language.set_state(@language.commentState)
      end

      # @see OOStructuredState
      def conditional_capture
        @language.set_state(@language.conditionalState)
      end

      # @see OOStructuredState
      def repetition_capture
        @language.set_state(@language.repetitionState)
      end

      # @see OOStructuredState
      def execute(pElementFile, pLine)

        # Having nothing to do
        return pElementFile
      end

    # End class
    end

  # End OOStructuredFSM
  end

# End StateMachine
end
