require_relative 'oo_structured_state.rb'

module StateMachine

  module OOStructuredFSM

    class IncludeState < OOStructuredState

      @language

      def initialize(pLanguage)
        @language = pLanguage
      end

      def handle_line(pLine)
        idle_capture
        # TODO: HANDLING MULTIPLE LINE COMMENT.
        #if @language.idleHandler.get_idle(pLine)
        #  idle_capture
        #else
        # TODO: SAME STATE.
        #end
      end

      def idle_capture
        @language.set_state(@language.idleState)
      end

      def execute(pElementFile, pLine)
        requirement = @language.externRequirementHandler.get_requirement(pLine)
        if requirement 
         pElementFile.add_extern_requirement(requirement)
        end
        # TODO: You have to handler the return state.
        idle_capture
        return pElementFile
      end

    # End class
    end

  # End OOStructuredFSM
  end

# End StateMachine
end
