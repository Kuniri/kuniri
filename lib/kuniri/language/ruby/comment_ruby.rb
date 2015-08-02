require_relative '../abstract_container/structured_and_oo/comment'

module Languages

  module Ruby

    # CommentRuby is responsible for handling ruby comments.
    class CommentRuby < Languages::Comment

      public

        @flagMultipleLine

        def initialize
          @flagMultipleLine = false
        end

        # @see Comment
        def get_comment(pLine)

          if is_single_line_comment?(pLine)
            return pLine.scan(/#(.*)/)[0].join
          end

          if is_multiple_line_comment_end?(pLine)
            @flagMultipleLine = false
            return ""
          end

          if @flagMultipleLine
            pLine = get_line_comment(pLine)
            return pLine
          end

          if is_multiple_line_comment?(pLine)
            @flagMultipleLine = true
            return ""
          end

          return nil
        end

        # @see Comment
        def is_single_line_comment?(pLine)
          return true if pLine =~ /#(.*)/
          return false
        end

        # @see Comment
        def is_multiple_line_comment?(pLine)
          if (pLine =~ /^=begin(.*?)/ || @flagMultipleLine)
            return true
          end
          return false
        end

        # @see Comment
        def is_multiple_line_comment_end?(pLine)
          # TODO: improve it
          return true if pLine =~ /^=end/
          return false
        end

      protected

        # @see Comment
        def detect_comment(pLine)
          return pLine.scan(/#(.*)/)[0].join if is_single_line_comment?(pLine)
          return nil
        end

        # @see Comment
        def get_line_comment(pString)
          return "" if pString =~ /=begin/
          return pString
        end

    # class
    end

  # module
  end

# module
end
