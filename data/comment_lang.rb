require_relative '../abstract_container/structured_and_oo/comment'

module Languages

  module {LANG}

    # Comment{LANG} is responsible for handling {LANG} comments.
    class Comment{LANG} < Languages::Comment

      public

        @flagMultipleLine

        def initialize
          @flagMultipleLine = false
        end

        # @see Comment
        def get_comment(pLine)
          # YOUR CODE HERE
        end

        # @see Comment
        def is_single_line_comment?(pLine)
          # YOUR CODE HERE
        end

        # @see Comment
        def is_multiple_line_comment?(pLine)
          # YOUR CODE HERE
        end

        # @see Comment
        def is_multiple_line_comment_end?(pLine)
          # YOUR CODE HERE
        end

      protected

        # @see Comment
        def prepare_line_comment(pString)
          # YOUR CODE HERE
        end

    # class
    end

  # module
  end

# module
end
