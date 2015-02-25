require_relative '../abstract_container/class.rb'
require_relative '../container_data/class_data.rb'

module Languages

  module Ruby

    class ClassRuby < Class
    # TODO
      public

        def get_class(pLine)
          result = detect_class(pLine)
          return nil unless result
          classCaptured = Languages::ClassData.new
          classCaptured.name = result
          return classCaptured
        end

      protected

        def detect_class(pLine)
          regexExpression = /^\s*class\b[ |\t]+\s*(.*)\b/
          return nil unless pLine =~ regexExpression
          return pLine.scan(regexExpression)[0].join("")
        end

        def get_inharitance
        end

    # class
    end
  
  # Ruby
  end

# Languages
end
