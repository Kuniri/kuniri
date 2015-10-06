require_relative '../abstract_container/structured_and_oo/comment'

module Languages

  module Csharp

    # CommentRuby is responsible for handling ruby comments.
    class CommentCsharp < Languages::Comment

      public

        @flagMultipleLine

        def initialize
          @flagMultipleLine = false
        end

        # @see Comment
        def get_comment(pLine)

          # Single line
          return pLine.scan(/\/\/(.*)/)[0].join if is_single_line_comment?(pLine)
          # Multiple line
          multipleLine = handle_multiple_line(pLine)
          return multipleLine if multipleLine
          return nil
        end

        # @see Comment
        def is_single_line_comment?(pLine)
          return true if pLine =~ /\/\/(.*)/
          return false
        end

        # @see Comment
        def is_multiple_line_comment?(pLine)
          return true if (pLine =~ /^\/\*(.*?)/ || @flagMultipleLine)
          return false
        end

        # @see Comment
        def is_multiple_line_comment_end?(pLine)
          return true if pLine =~ /^\*\//
          return false
        end

      protected

        # @see Comment
        def prepare_line_comment(pString)
          return "" if pString =~ /\/\*/
          return pString
        end

      private

        def handle_multiple_line(pLine)
          if is_multiple_line_comment_end?(pLine)
            @flagMultipleLine = false
            return ""
          end

          if @flagMultipleLine
            pLine = prepare_line_comment(pLine)
            return pLine
          end

          if is_multiple_line_comment?(pLine)
            @flagMultipleLine = true
            return ""
          end

          return nil
        end

    # class
    end

  # module
  end

# module
end