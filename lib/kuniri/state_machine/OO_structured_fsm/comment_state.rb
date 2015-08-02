require_relative 'oo_structured_state'

module StateMachine

  module OOStructuredFSM

    # CommentState is responsible for handling comments.
    class CommentState < OOStructuredState

      @language
      @multipleLineComment

      def initialize(pLanguage)
        @language = pLanguage
      end

      def handle_line(pLine)
        # Nothing
      end

      # @see OOStructuredState
      def comment_capture
        @language.set_state(@language.commentState)
      end

      # @see OOStructuredState
      def idle_capture
        @language.rewind_state
      end

      # @see OOStructuredState
      def class_capture
        @language.rewind_state
      end

      # @see OOStructuredState
      def execute(pElementFile, pLine)
        comment_string = @language.commentHandler.get_comment(pLine)

        if comment_string
          comment_string += "\n"
          @language.string_comment_to_transfer += comment_string 
        end

        if ((not @multipleLineComment) or 
            (comment_string == StateMachine::END_MULTIPLE_LINE_COMMENT))
          if (previous.is_a? (StateMachine::OOStructuredState::IdleState))
            idle_capture
          elsif (previous.is_a? (StateMachine::OOStructuredState::ClassState))
            class_capture
          end
        end

        return pElementFile

      end

    # class
    end

  # module
  end

# module
end
