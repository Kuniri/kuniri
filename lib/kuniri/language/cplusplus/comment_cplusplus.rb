require_relative '../abstract_container/structured_and_oo/comment'

module Languages

  module Cplusplus

    # CommentCplusplus is responsible for handling cplusplus comments.
    class CommentCplusplus < Languages::Comment

      public

        @flagMultipleLine

        def initialize
          @flagMultipleLine = false
        end

        # @see Comment
        def get_comment(pLine)

          # Single line
          return pLine.scan(/#(.*)/)[0].join if is_single_line_comment?(pLine)

          # Multiple line
          multipleLine = handle_multiple_line(pLine)
          return multipleLine if multipleLine
          return nil
        end

        # @see Comment
        def is_single_line_comment?(pLine)
          return true if pLine =~ /#(.*)/
          return false
        end

        # @see Comment
        def is_multiple_line_comment?(pLine)
          return true if (pLine =~ /^=begin(.*?)/ || @flagMultipleLine)
          return false
        end

        # @see Comment
        def is_multiple_line_comment_end?(pLine)
          return true if pLine =~ /^=end/
          return false
        end

      protected

        # @see Comment
        def prepare_line_comment(pString)
          return "" if pString =~ /=begin/
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
