#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

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
        @multipleLineComment = ''
        @enableMultipleLine = false
      end

      def handle_line(pLine)
      end

      # @see OOStructuredState
      def execute(pElementFile, pLine)
        # Single line
        if @language.commentHandler.is_single_line_comment?(pLine)
          handling_single_line(pLine)
          return pElementFile
        end

        # Multiple line
        if @language.commentHandler.is_multiple_line_comment?(pLine)
          @enableMultipleLine = true
        end

        if @language.commentHandler.is_multiple_line_comment_end?(pLine)
          handling_multiple_line
        end

        if @enableMultipleLine
          capture_multiple_line_comment(pLine)
        end

        return pElementFile
      end

      private

        def handling_single_line(pLine)
          comment_string = @language.line_inspect(COMMENT_ID, pLine)
          @language.string_comment_to_transfer += comment_string
          apply_final_adjustments!(@language.string_comment_to_transfer)
          @language.rewind_state
        end

        def handling_multiple_line
          @enableMultipleLine = false
          apply_final_adjustments!(@multipleLineComment)
          @language.string_comment_to_transfer = @multipleLineComment
          @multipleLineComment = ''
          @language.rewind_state
        end

        def capture_multiple_line_comment(pLine)
          comment_string = @language.line_inspect(COMMENT_ID, pLine)
          @multipleLineComment += comment_string
        end

        def apply_final_adjustments!(pComment)
          pComment.strip!
          pComment.squeeze!(' ')
        end

    # class
    end
  # module
  end
# module
end
