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
      def initialize(pLanguage)
        @language = pLanguage
      end

      # @see OOStructuredState
      def handle_line(pLine)
        structures = {
          EXTERN_REQUIREMENT_ID => method(:include_capture),
          VARIABLE_ID => method(:variable_capture),
          FUNCTION_ID => method(:function_capture),
          MODULE_ID => method(:module_capture),
          CLASS_ID => method(:class_capture),
          CONDITIONAL_ID => method(:conditional_capture),
          REPETITION_ID => method(:repetition_capture),
          BLOCK_ID => method(:block_capture)
        }

        structures.each do |id, function|
          return function.call if @language.line_inspect(id, pLine)
        end

        if ((@language.commentHandler.single_line_comment?(pLine)) ||
               (@language.commentHandler.multiple_line_comment?(pLine)))
          comment_capture
        end

        return
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
        @language.flagFunctionBehaviour = StateMachine::SCRIPT_STATE
        @language.set_state(@language.conditionalState)
      end

      # @see OOStructuredState
      def repetition_capture
        @language.flagFunctionBehaviour = StateMachine::SCRIPT_STATE
        @language.set_state(@language.repetitionState)
      end

      # @see OOStructuredState
      def block_capture
        @language.flagFunctionBehaviour = StateMachine::SCRIPT_STATE
        @language.set_state(@language.blockState)
      end

      # @see OOStructuredState
      def execute(pElementFile, _pLine)
        # Having nothing to do
        return pElementFile
      end

    end # End class
  end # End OOStructuredFSM
end # End StateMachine
