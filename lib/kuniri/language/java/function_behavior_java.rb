require_relative '../abstract_container/structured_and_oo/function_behavior'
require_relative '../../core/setting'
require_relative '../container_data/structured_and_oo/function_data'

module Languages

  module Java

    # Handling Java method
    class FunctionBehaviorJava < Languages::FunctionBehavior

      public

        def initialize
          @log = @settings = Kuniri::Setting.create.log
        end

        def get_function(pLine, type = 'globalFunction')
          result = detect_function(pLine)
          return nil unless result

          @log.write_log("Info: get method")

          functionJava = Languages::FunctionData.new(result)

          parameters = handling_parameter(pLine)
          if parameters
            parameters.each do |parameter|
              functionJava.add_parameters(parameter)
            end
          end
 
          @log.write_log("Debug: Method: #{functionJava.name}, Parameter:
                         #{functionJava.parameters}")

          return functionJava
        end

      protected

        def detect_function(pLine)
          regexExpression = /^\s*def\b\s*(\w*)\b/
          return nil unless pLine =~ regexExpression
          return pLine.scan(regexExpression)[0].join("")
        end

        def handling_default_parameter(pLine)
          return pLine unless pLine =~ /=/

          if pLine =~ /,/
            partialParameters = pLine.split(",")
          else
            partialParameters = [pLine]
          end

          newList = []
          partialParameters.each do |element|
            if element =~ /=/
              parameter = element.scan(/(\w*)=/).join("")
              value = element.scan(/=(\w*)/).join("")
              defaultParameter = Hash(parameter => value)
              newList.push(defaultParameter)
              next
            end
            newList.push(element)
          end

          return newList

        end

        def remove_unnecessary_information(pLine)
          return pLine.gsub(/\s+|\(|\)/,"") if pLine =~ /\s+|\(|\)/
          return pLine
        end

        def handling_parameter(pLine)
          # Handling with parenthesis and without it.
          if pLine =~ /\(.+\)/
            partial = get_parameters(pLine, /\(.+\)/)
          elsif pLine =~ /def\s+\w+[\s]+(.+)/
            partial = get_parameters(pLine, /def\s+\w+[\s]+(.+)/)
          else
            return nil
          end

          return handling_default_parameter(partial) if partial =~ /=/
          return split_string_by_comma(partial)
        end

      private

        @log

        def get_parameters(pLine, pRegex)
          partialParameters = pLine.scan(pRegex).join("")
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
