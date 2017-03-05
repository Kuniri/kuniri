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

      public

      # Get ruby conditional.
      # @see Languages::Conditional
      def get_conditional(pLine)
        result = detect_conditional(pLine)
        return nil unless result
        return result
      end

      protected

      # Override.
      def detect_conditional(pLine)
        regexExp = /^\s*if\s+(.*)/
        return build_data(pLine[regexExp, 1], Languages::IF_LABEL) if regexExp =~ pLine

        regexExp = /.+\s+if\s+(.*)/
        return build_data(pLine[regexExp, 1], Languages::IF_LABEL, true) if regexExp =~ pLine

        regexExp = /^\s*case\s+(.*)/
        return build_data(pLine[regexExp, 1], Languages::CASE_LABEL) if regexExp =~ pLine

        regexExp = /^\s*when\s+(.*)/
        return build_data(pLine[regexExp, 1], Languages::WHEN_LABEL) if regexExp =~ pLine

        regexExp = /^\s*unless\s+(.*)/
        return build_data(pLine[regexExp, 1], Languages::UNLESS_LABEL) if regexExp =~ pLine

        regexExp = /.+\s+unless\s+(.*)/
        return build_data(pLine[regexExp, 1], Languages::UNLESS_LABEL, true) if regexExp =~ pLine

        regexExp = /^\s*elsif\s+(.*)/
        return build_data(pLine[regexExp, 1], Languages::ELSIF_LABEL) if regexExp =~ pLine

        regexExp = /^\s*else\s*/
        return build_data(pLine[regexExp, 1], Languages::ELSE_LABEL, false, false) if regexExp =~ pLine

        regexExp = /(.*)\?.*\:.*/
        return build_data(pLine[regexExp, 1], Languages::TERNARY_LABEL, true) if regexExp =~ pLine

        return nil
      end

      # Override
      def get_expression(pString)
        return pString.strip
      end

      private

      def build_data(pLine, pLabel, pSingleLine = false, pExpr = true)
        conditionalCaptured = Languages::ConditionalData.new
        conditionalCaptured.type = pLabel
        conditionalCaptured.singleLine = pSingleLine
        conditionalCaptured.expression = get_expression(pLine) if pExpr
        return conditionalCaptured
      end
    # Class
    end

  # Module
  end

# Module
end
