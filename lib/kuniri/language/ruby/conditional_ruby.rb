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
          # TODO: Refactor this code, it can be much better
          conditionalCaptured = Languages::ConditionalData.new
          conditionalCaptured.type = conditional_type(pLine)
          conditionalCaptured.singleLine = single_line?(pLine)

          unless conditionalCaptured.type == Languages::ELSE_LABEL
            conditionalCaptured.expression = get_expression(result)
          end

          return conditionalCaptured
        end

      protected

        # Override.
        # TODO: it gonna be better if this method return ConditionData
        def detect_conditional(pLine)
          # TODO: change the use of scan and vector syntax. It's confusing.
          regexExp = /^if\s+(.*)/
          return pLine[regexExp, 1] if regexExp =~ pLine

          regexExp = /.*\s+if\s+(.*)/
          return pLine[regexExp, 1] if regexExp =~ pLine

          regexExp = /^\s*case\s+(.*)/
          return pLine.scan(regexExp)[0].join('') if regexExp =~ pLine

          regexExp = /^\s*when\s+(.*)/
          return pLine.scan(regexExp)[0].join('') if regexExp =~ pLine

          #regexExp = /^\s*unless\s+(.*)/
          regexExp = /^unless\s+(.*)|.*\s+unless\s+(.*)/
          return pLine.scan(regexExp)[0].join('') if regexExp =~ pLine

          regexExp = /^\s*elsif\s+(.*)/
          return pLine.scan(regexExp)[0].join('') if regexExp =~ pLine

          regexExp = /^\s*else\s*/
          return pLine.scan(regexExp)[0].gsub(' ', '') if regexExp =~ pLine

          return nil
        end

        # Override
        def conditional_type(pString)
          regexExp = /^if\s+(.*)|.*\s+if\s+(.*)/
          return Languages::IF_LABEL if regexExp =~ pString

          regexExp = /^\s+case|^case/
          return Languages::CASE_LABEL if regexExp =~ pString

          regexExp = /^\s+when|^when/
          return Languages::WHEN_LABEL if regexExp =~ pString

          regexExp = /^unless\s+(.*)|.*\s+unless\s+(.*)/
          return Languages::UNLESS_LABEL if regexExp =~ pString

          regexExp = /^\s+elsif|^elsif/
          return Languages::ELSIF_LABEL if regexExp =~ pString

          regexExp = /^\s+else|^else/
          return Languages::ELSE_LABEL if regexExp =~ pString

          return nil
        end

        # Override
        def get_expression(pString)
          pString = pString.strip
          return pString
        end

        # TODO: This can be improved!
        def single_line?(pString)
          return false if /elsif/ =~ pString.lstrip
          return true if /^.+if\s+(.*)/ =~ pString.lstrip
          return true if /^.+unless\s+(.*)/ =~ pString.lstrip
          return false
        end

    # Class
    end

  # Module
  end

# Module
end
