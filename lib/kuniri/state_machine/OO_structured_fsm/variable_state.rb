#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

require_relative 'oo_structured_state'

module StateMachine

  module OOStructuredFSM

    # Handling variable state.
    class VariableState < OOStructuredState
      def initialize(pLanguage)
        @language = pLanguage
      end

      # @see OOStructuredState
      def handle_line(_pLine)
        idle_capture
      end

      # @see OOStructuredState
      def idle_capture
        @language.set_state(@language.idleState)
      end

      # @see OOStructuredState
      def execute(pElementFile, _pLine)
        variableList = @language.processed_line
        if variableList
          variableList.each do |variable|
            variable.comments = @language.string_comment_to_transfer
          end
          @language.string_comment_to_transfer = ''
          pElementFile.add_global_variable(variableList)
        end

        idle_capture
        return pElementFile
      end

    end # End clas
  end # End OOStructuredFSM
end # End StateMachine
