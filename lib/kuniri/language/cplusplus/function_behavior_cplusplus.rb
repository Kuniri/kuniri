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
          regexExpression = /\w*\s*(\w*)\s*(::)\s*(\w*)\s*\((?:.*)\)\s*/
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

          pLine.gsub!(/, /,",") if pLine =~ /.*, .*/
          pLine.gsub!(/\s{2,}/," ") if pLine =~ /\s+/
          pLine.gsub!(/\(|\)/,"") if pLine =~ /\(|\)/
          puts pLine
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
          return pString.split(",") if pString =~ /,/
          return [pString]
        end

    # Class
    end

  # Cplusplus
  end

# Language
end
