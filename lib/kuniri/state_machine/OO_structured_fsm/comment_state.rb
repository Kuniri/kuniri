require_relative 'oo_structured_state'

module StateMachine

  module OOStructuredFSM

    # CommentState is responsible for handling comments.
    class CommentState < OOStructuredState

      @language
      @multipleLineComment

      def initialize(pLanguage)
        @language = pLanguage
        @commentString = ""
      end

      def handle_line(pLine)
        # TODO
      end

      # @see OOStructuredState
      def execute(pElementFile, pLine)

        if @language.commentHandler.is_single_line_comment?(pLine)
          comment_string = @language.commentHandler.get_comment(pLine)
          comment_string += "\n"
          @language.string_comment_to_transfer += comment_string
          @language.rewind_state
        elsif @language.commentHandler.is_multiple_line_comment?(pLine)
          @multipleLineComment += @language.commentHandler.get_comment(pLine)
          @multipleLineComment += "\n"
        elsif @language.commentHandler.is_multiple_line_comment_end?(pLine)
          @language.string_comment_to_transfer = @multipleLineComment
          @multipleLineComment = ""
          @language.rewind_state
        end
 
        return pElementFile

      end

    # class
    end

  # module
  end

# module
end
