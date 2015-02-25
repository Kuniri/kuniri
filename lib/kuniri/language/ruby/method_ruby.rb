require_relative '../abstract_container/method.rb'
require_relative '../container_data/method_data.rb'

module Languages

  module Ruby

    # Handling ruby method
    class MethodRuby < Method
      # TODO
      public

        def get_method(pLine)
          result = detect_method(pLine)
          return nil unless result
          methodRuby = Languages::MethodData.new(result)
          return methodRuby
        end

      protected

        def detect_method(pLine)
          regexExpression = /^\s*def\b\s*(\w*)\b/
          return nil unless pLine =~ regexExpression
          return pLine.scan(regexExpression)[0].join("")
        end

        def handling_parameter(pLine)
        end

    # Class
    end

  # Ruby
  end

# Language
end
