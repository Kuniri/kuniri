#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

require_relative 'oo_structured_state'

module StateMachine

  module OOStructuredFSM

    # Class responsible for handling Include state.
    class IncludeState < OOStructuredState
      def initialize(pLanguage)
        @language = pLanguage
      end

      # @see OOStructuredState
      def handle_line(_pLine)
        idle_capture
        # TODO: HANDLING MULTIPLE LINE.
        # if @language.idleHandler.get_idle(pLine)
        #   idle_capture
        # else
        #  TODO: SAME STATE.
        # end
      end

      # @see OOStructuredState
      def idle_capture
        @language.set_state(@language.idleState)
      end

      # @see OOStructuredState
      def execute(pElementFile, _pLine)
        requirement = @language.processed_line

        pElementFile.add_extern_requirement(requirement) if requirement

        idle_capture

        if (@language.state.is_a? StateMachine::OOStructuredFSM::IdleState)
          pElementFile.comments = @language.string_comment_to_transfer
          @language.string_comment_to_transfer = ''
        end

        return pElementFile
      end

    end # End class
  end # End OOStructuredFSM
end # End StateMachine
