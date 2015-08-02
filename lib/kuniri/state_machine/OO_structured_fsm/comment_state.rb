require_relative 'oo_structured_state'

module StateMachine

  module OOStructuredFSM

    # CommentState is responsible for handling comments.
    class CommentState < OOStructuredState

      @language
      @multipleLineComment
      @enableMultipleLine

      def initialize(pLanguage)
        @language = pLanguage
        @multipleLineComment = ""
        @enableMultipleLine = false
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
        end

        # Multiple line handling
        if @language.commentHandler.is_multiple_line_comment?(pLine)
          @enableMultipleLine = true
        end

        if @language.commentHandler.is_multiple_line_comment_end?(pLine)
          @enableMultipleLine = false
          @language.string_comment_to_transfer = @multipleLineComment
          @multipleLineComment = ""
          @language.rewind_state
        end

        if @enableMultipleLine
          comment_string = @language.commentHandler.get_comment(pLine)
          @multipleLineComment += comment_string
        end
 
        return pElementFile

      end

    # class
    end

  # module
  end

# module
end
