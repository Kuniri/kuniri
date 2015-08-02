require_relative '../abstract_container/structured_and_oo/comment'

module Languages

  module Ruby

    # CommentRuby is responsible for handling ruby comments.
    class CommentRuby < Languages::Comment

      public

        # @see Comment
        def get_comment(pLine)
          result = detect_comment(pLine)
          return nil unless result

          result = get_line_comment(result)
          return result
        end

        # @see Comment
        def is_single_line_comment?(pLine)
          return true if pLine =~ /#(.*)/
          return false
        end

        # @see Comment
        def is_multiple_line_comment?(pLine)
          return true if pLine =~ /=begin(.*?)/
          return false
        end

        # @see Comment
        def is_multiple_line_comment_end?(pLine)
          # TODO: improve it
          return true if pLine =~ /=end/
          return false
        end

      protected

        # @see Comment
        def detect_comment(pLine)
          regex = /#(.*)/
          return pLine.scan(regex)[0].join if pLine =~ regex
          return nil
        end

        # @see Comment
        def get_line_comment(pString)
          # TODO: Handling string
          return pString
        end

    # class
    end

  # module
  end

# module
end
