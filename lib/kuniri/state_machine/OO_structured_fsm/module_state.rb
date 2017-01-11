#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

require_relative 'oo_structured_state'
require_relative 'function_state'
require_relative 'class_state'
require_relative 'idle_state'

module StateMachine

  module OOStructuredFSM

    # Class responsible for handling Module state.
    class ModuleState < OOStructuredState

      @language

      def initialize(pLanguage)
        @language = pLanguage
      end

      # @see OOStructuredState
      def handle_line(pLine)
        if @language.line_inspect(CLASS_ID, pLine)
          class_capture
        elsif @language.line_inspect(FUNCTION_ID, pLine)
          function_capture
        elsif @language.line_inspect(VARIABLE_ID, pLine)
          variable_capture
        end
      end

      # @see OOStructuredState
      def idle_capture
        @language.set_state(@language.idleState)
      end

      # @see OOStructuredState
      def class_capture
        @language.set_state(@language.classState)
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
      def execute(pElementFile, pLine)

        moduleElement = @language.line_inspect(MODULE_ID, pLine)

        if moduleElement
          pElementFile.add_modules(moduleElement)
        end

        if @language.endBlockHandler.has_end_of_block?(pLine)
          previous = @language.previousState.last

          if (previous.is_a?(StateMachine::OOStructuredFSM::IdleState))
            idle_capture
          else
            return pElementFile
          end
        end

        return pElementFile
      end

    # End class
    end

  # End OOStructuredFSM
  end

# End StateMachine
end
