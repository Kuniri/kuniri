require_relative '../abstract_container/structured_and_oo/conditional.rb'
require_relative '../container_data/structured_and_oo/conditional_data.rb'

module Languages

  module Java

    class ConditionalJava < Languages::Conditional

      public

        def get_conditional(pLine)
          result = detect_conditional(pLine)
          return nil unless result

          conditionalCaptured = Languages::ConditionalData.new
          conditionalCaptured.type = conditional_type(pLine)

          conditionalCaptured.expression = get_expression(result)

          return conditionalCaptured
        end

      protected

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

        def get_expression(pString)
          leftStrip = pString.lstrip
          rightStrip = leftStrip.rstrip
          return rightStrip
        end

    # Class
    end

  # Java
  end

# Module
end
