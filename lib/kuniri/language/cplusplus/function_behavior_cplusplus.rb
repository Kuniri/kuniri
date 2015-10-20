require_relative '../abstract_container/structured_and_oo/function_behavior'
require_relative '../../core/setting'
require_relative '../container_data/structured_and_oo/function_data'

module Languages

  module Cplusplus

    # Handling Cplusplus method
    class FunctionBehaviorCplusplus < Languages::FunctionBehavior

      public

        def initialize
          @log = @settings = Kuniri::Setting.create.log
        end

        def get_function(pLine, type = 'globalFunction')
          result = detect_function(pLine)
          return nil unless result

          @log.write_log("Info: get method")

          functionCplusplus = Languages::FunctionData.new(result)

          parameters = handling_parameter(pLine)
          if parameters
            parameters.each do |parameter|
              functionCplusplus.add_parameters(parameter)
            end
          end

          @log.write_log("Debug: Method: #{functionCplusplus.name}, Parameter:
                         #{functionCplusplus.parameters}")

          return functionCplusplus
        end

      protected

        def detect_function(pLine)
          regexExpression = /\s*(\w+)\s*(\w+)\s*::\s*(\w+)\s*\(.*\)\s*/
          return nil unless pLine =~ regexExpression

          return $3
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

          pLine.gsub!(/, /,",") if pLine =~ /.*, .*/
          pLine.gsub!(/\s+/," ") if pLine =~ /\s+/
          pLine.gsub!(/\(\s*|\s*\)/,"") if pLine =~ /\(\s*|\s*\)/
          pLine.gsub!(/\s,|,\s/,",") if pLine =~ /\s,|,\s/

          return pLine
        end

        def handling_parameter(pLine)
          # Handling with parenthesis and without it.
          if pLine =~ /\(.+\)/
            partial = get_parameters(pLine, /\(.+\)/)
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
          if pString =~ /,/
            splittedString = pString.split(",")
            splittedString.each do |element|
              element.lstrip!
              element.rstrip!
            end
            return splittedString
          end
          return [pString]
        end

    # Class
    end

  # Cplusplus
  end

# Language
end
