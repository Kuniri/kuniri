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
        if @language.externRequirementHandler.get_requirement(pLine)
          include_capture
        elsif @language.variableHandler.get_variable(pLine)
          variable_capture
        elsif @language.functionHandler.get_function(pLine)
          function_capture
        elsif @language.moduleHandler.get_module(pLine)
          module_capture
        elsif @language.classHandler.get_class(pLine)
          class_capture
        elsif ((@language.commentHandler.is_single_line_comment?(pLine)) || 
                (@language.commentHandler.is_multiple_line_comment?(pLine)))
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
