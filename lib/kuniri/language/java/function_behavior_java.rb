require_relative '../abstract_container/structured_and_oo/function_behavior'
require_relative '../../core/setting'
require_relative '../container_data/structured_and_oo/function_data'

module Languages

  module Java

    # Handling Java method
    class FunctionBehaviorJava < Languages::FunctionBehavior

      public

        def initialize
        end

        def get_function(pLine, type = 'globalFunction')
          pLine.gsub!(/\s{2,}/, " ")
          result = detect_function(pLine)
          return nil unless result

          functionJava = Languages::FunctionData.new(result)

          parameters = handling_parameter(pLine)
          if parameters
            parameters.each do |parameter|
              functionJava.add_parameters(parameter)
            end
          end

          return functionJava
        end

      protected

        def detect_function(pLine)
          access = /(?:(?:public|private|protected|package)\s)/
          modifier = /(?:(?:abstract|final|static|synchronized)\s)/
          return_type = /(?:(?:\w+)\s)/
          regexExpression = /^\s?#{access}?#{modifier}?#{return_type}?(\w+)\s?\(.*\)/
          return nil unless pLine =~ regexExpression

          return pLine.scan(regexExpression)[0].join("")
        end

        def remove_unnecessary_information(pLine)
          return pLine.gsub!(/,\s/, ",") if pLine =~ /\w+,\s\w+/
          return pLine.gsub!(/\s,/, ",") if pLine =~ /\w+\s,\w+/
          return pLine.gsub!(/\s,\s/, ",") if pLine =~ /\w+\s,\s\w+/
          return pLine
        end

        def handling_parameter(pLine)
          if pLine =~ /\(.+\)/
            partial = get_parameters(pLine, /\((.+)\)/)
          else
            return nil
          end

          return split_string_by_comma(partial)
        end

      private
    
        def get_parameters(pLine, pRegex)
          partialParameters = pLine.scan(pRegex).join("")
          partialParameters.lstrip!
          partialParameters.rstrip!
          partialParameters = remove_unnecessary_information(partialParameters)
          return partialParameters
        end

        def split_string_by_comma(pString)
          return pString.split(",") if pString =~ /,/
          return [pString]
        end

    # Class
    end

  # Java
  end

# Language
end
