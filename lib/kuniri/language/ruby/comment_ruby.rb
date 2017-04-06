#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

require_relative '../abstract_container/structured_and_oo/comment'

module Languages

  module Ruby

    # CommentRuby is responsible for handling ruby comments.
    class CommentRuby < Languages::Comment
      def initialize
        @flagMultipleLine = false
      end

      # @see Comment
      def get_comment(pLine)
        # Single line
        if single_line_comment?(pLine)
          partialString = pLine.scan(/#(.*)/)[0].join
          return normalize_comments(partialString)
        end

        # Multiple line
        multipleLine = handle_multiple_line(pLine)
        return multipleLine if multipleLine
        return nil
      end

      # @see Comment
      def single_line_comment?(pLine)
        return true if pLine =~ /#(.*)/
        return false
      end

      # @see Comment
      def multiple_line_comment?(pLine)
        return true if (pLine =~ /^=begin(.*?)/ || @flagMultipleLine)
        return false
      end

      # @see Comment
      def multiple_line_comment_end?(pLine)
        return true if pLine =~ /^=end/
        return false
      end

      protected

      # @see Comment
      def prepare_line_comment(pString)
        return '' if pString =~ /=begin/
        return pString
      end

      def normalize_comments(pString)
        return pString.tr("\n", ' ')
      end

      private

      def handle_multiple_line(pLine)
        if multiple_line_comment_end?(pLine)
          @flagMultipleLine = false
          return ''
        end

        if @flagMultipleLine
          pLine = prepare_line_comment(pLine)
          pLine = normalize_comments(pLine)
          return pLine
        end

        if multiple_line_comment?(pLine)
          @flagMultipleLine = true
          return ''
        end

        return nil
      end
    end # class
  end # module
end # module
