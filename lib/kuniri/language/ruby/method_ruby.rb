require_relative '../method.rb'

module Languages

  module Ruby

    class MethodRuby < Method

      public

        def get_method(pLine)
          result = detect_method(pLine)
          return nil unless result
          return result
        end

      protected

        def detect_method(pLine)
          regexExpression = /^\s*def\b\s*(\w*)\b/
          return nil unless pLine =~ regexExpression
          return pLine.scan(regexExpression)[0]
        end

        def handling_parameter(pLine)
        end

    # Class
    end

  # Ruby
  end

# Language
end
