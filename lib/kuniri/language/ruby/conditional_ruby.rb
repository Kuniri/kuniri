#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

require_relative '../abstract_container/structured_and_oo/conditional'
require_relative '../abstract_container/structured_and_oo/global_tokens'
require_relative '../container_data/structured_and_oo/conditional_data'

module Languages

  module Ruby

    # Class responsible for handling ruby conditional statements.
    class ConditionalRuby < Languages::Conditional

      # Get ruby conditional.
      # @see Languages::Conditional
      def get_conditional(pLine)
        @line = pLine
        result = detect_conditional(pLine)
        return nil unless result
        return result
      end

      protected

      # Override.
      def detect_conditional(pLine)
        case pLine
        when IF_REGEX
          return build_data(IF_REGEX, Languages::IF_LABEL)
        when IF_INLINE_REGEX
          return build_data(IF_INLINE_REGEX, Languages::IF_LABEL, true)
        when CASE_REGEX
          return build_data(CASE_REGEX, Languages::CASE_LABEL)
        when WHEN_REGEX
          return build_data(WHEN_REGEX, Languages::WHEN_LABEL)
        when UNLESS_REGEX
          return build_data(UNLESS_REGEX, Languages::UNLESS_LABEL)
        when UNLESS_INLINE_REGEX
          return build_data(UNLESS_INLINE_REGEX, Languages::UNLESS_LABEL, true)
        when ELSIF_REGEX
          return build_data(ELSIF_REGEX, Languages::ELSIF_LABEL)
        when ELSE_REGEX
          return build_data(ELSE_REGEX, Languages::ELSE_LABEL, false, false)
        when TERNARY_REGEX
          return build_data(TERNARY_REGEX, Languages::TERNARY_LABEL, true)
        else
          return nil
        end
      end

      # Override
      def get_expression(pString)
        return pString.strip
      end

      private

      IF_REGEX = /^\s*if\s+(.*)/
      IF_INLINE_REGEX = /.+\s+if\s+(.*)/
      CASE_REGEX = /^\s*case\s+(.*)/
      WHEN_REGEX = /^\s*when\s+(.*)/
      UNLESS_REGEX = /^\s*unless\s+(.*)/
      UNLESS_INLINE_REGEX = /.+\s+unless\s+(.*)/
      ELSIF_REGEX = /^\s*elsif\s+(.*)/
      ELSE_REGEX = /^\s*else\s*/
      TERNARY_REGEX = /(.*)\?.*\:.*/

      @line = ''

      def build_data(pRegex, pLabel, pSingleLine = false, pExpression = true)
        conditionalCaptured = Languages::ConditionalData.new
        conditionalCaptured.type = pLabel
        conditionalCaptured.singleLine = pSingleLine
        if pExpression
          conditionalCaptured.expression = get_expression(@line[pRegex, 1])
        end
        return conditionalCaptured
      end
    end # End of Class
  end # End of Ruby Module
end # End of Languages Module
