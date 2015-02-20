require_relative '../class.rb'

module Languages

  module Ruby

    class ClassRuby < Class

      public

        def get_class(pLine)
          result = detect_class(pLine)
          return nil unless result
          return result
        end

      protected

        def detect_class(pLine)
          regexExpression = /^\s*class\b[ |\t]+\s*(.*)\b/
          return nil unless pLine =~ regexExpression
          return pLine.scan(regexExpression)[0]
        end

        def get_inharitance
        end

    # class
    end
  
  # Ruby
  end

# Languages
end
