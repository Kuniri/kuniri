require_relative 'oo_structured_state'

module StateMachine

  module OOStructuredFSM

    # Class responsible for handling Include state.
    class IncludeState < OOStructuredState

      @language

      def initialize(pLanguage)
        @language = pLanguage
      end

      # @see OOStructuredState
      def handle_line(pLine)
        idle_capture
        # TODO: HANDLING MULTIPLE LINE COMMENT.
        #if @language.idleHandler.get_idle(pLine)
        #  idle_capture
        #else
        # TODO: SAME STATE.
        #end
      end

      # @see OOStructuredState
      def idle_capture
        @language.set_state(@language.idleState)
      end

      # @see OOStructuredState
      def execute(pElementFile, pLine)
        requirement = @language.externRequirementHandler.get_requirement(pLine)
        if requirement 
         pElementFile.add_extern_requirement(requirement)
        end
        # TODO: You have to handler the return state.
        idle_capture

        if (@language.state.is_a? StateMachine::OOStructuredFSM::IdleState)
          pElementFile.comments = @language.string_comment_to_transfer
          @language.string_comment_to_transfer = ""
        end

        return pElementFile
      end

    # End class
    end

  # End OOStructuredFSM
  end

# End StateMachine
end
