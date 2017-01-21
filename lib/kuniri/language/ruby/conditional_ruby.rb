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

          conditionalCaptured = Languages::ConditionalData.new
          conditionalCaptured.type = conditional_type(pLine)
          unless conditionalCaptured.type == Languages::ELSE_LABEL
            conditionalCaptured.expression = get_expression(result)
          end

          return conditionalCaptured
        end

      protected

        # Override.
        def detect_conditional(pLine)
          regexExp = /^\s*if\s+(.*)/
          return pLine.scan(regexExp)[0].join("") if regexExp =~ pLine

          regexExp = /^\s*case\s+(.*)/
          return pLine.scan(regexExp)[0].join("") if regexExp =~ pLine

          regexExp = /^\s*when\s+(.*)/
          return pLine.scan(regexExp)[0].join("") if regexExp =~ pLine

          regexExp = /^\s*unless\s+(.*)/
          return pLine.scan(regexExp)[0].join("") if regexExp =~ pLine

          regexExp = /^\s*elsif\s+(.*)/
          return pLine.scan(regexExp)[0].join("") if regexExp =~ pLine

          regexExp = /^\s*else\s*/
          return pLine.scan(regexExp)[0].gsub(" ", "") if regexExp =~ pLine

          return nil
        end

        # Override
        def conditional_type(pString)
          regexExp = /^\s+if|^if/
          return Languages::IF_LABEL if regexExp =~ pString

          regexExp = /^\s+case|^case/
          return Languages::CASE_LABEL if regexExp =~ pString

          regexExp = /^\s+when|^when/
          return Languages::WHEN_LABEL if regexExp =~ pString

          regexExp = /^\s+unless|^unless/
          return Languages::UNLESS_LABEL if regexExp =~ pString

          regexExp = /^\s+elsif|^elsif/
          return Languages::ELSIF_LABEL if regexExp =~ pString

          regexExp = /^\s+else|^else/
          return Languages::ELSE_LABEL if regexExp =~ pString

          return nil
        end

        # Override
        def get_expression(pString)
          leftStrip = pString.lstrip
          rightStrip = leftStrip.rstrip
          return rightStrip
        end

    # Class
    end

  # Module
  end

# Module
end
