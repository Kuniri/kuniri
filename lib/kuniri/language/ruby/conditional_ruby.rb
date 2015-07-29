require_relative '../abstract_container/structured_and_oo/conditional'
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

          conditionalCaptured.expression = get_expression(result)

          return conditionalCaptured
        end

      protected

        # Override.
        def detect_conditional(pLine)
          regexExp = /^\s*if\s+(.*)/
          return pLine.scan(regexExp)[0].join("") if regexExp =~ pLine

          regexExp = /^\s*case\s+(.*)/
          return pLine.scan(regexExp)[0].join("") if regexExp =~ pLine

          regexExp = /^\s*unless\s+(.*)/
          return pLine.scan(regexExp)[0].join("") if regexExp =~ pLine

          regexExp = /^\s*elsif\s+(.*)/
          return pLine.scan(regexExp)[0].join("") if regexExp =~ pLine

          return nil
        end

        # Override
        def conditional_type(pString)
          regexExp = /^\s+if|^if/
          return "IF" if regexExp =~ pString

          regexExp = /^\s+case|^case/
          return "CASE" if regexExp =~ pString

          regexExp = /^\s+unless|^unless/
          return "UNLESS" if regexExp =~ pString

          regexExp = /^\s+elsif|^elsif/
          return "ELSIF" if regexExp =~ pString

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
