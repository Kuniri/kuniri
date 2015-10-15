require_relative '../abstract_container/structured_and_oo/function_behavior'
require_relative '../../core/setting'
require_relative '../container_data/structured_and_oo/function_data'

module Languages

  module Csharp

    # Handling Csharp method
    class FunctionBehaviorCsharp < Languages::FunctionBehavior

      public

        def initialize
          @log = @settings = Kuniri::Setting.create.log
        end

        def get_function(pLine, type = 'globalFunction')
          pLine.gsub!(/\s{2,}/," ")
          result = detect_function(pLine)
          return nil unless result

          @log.write_log("Info: get method")

          functionCsharp = Languages::FunctionData.new(result)

          parameters = handling_parameter(pLine)
          if parameters
            parameters.each do |parameter|
              functionCsharp.add_parameters(parameter)
            end
          end
 
          @log.write_log("Debug: Method: #{functionCsharp.name}, Parameter:
                         #{functionCsharp.parameters}")

          return functionCsharp
        end

      protected

        def detect_function(pLine)
          regexExpression = /\s?(?:\w+)\s(\w+)\s?\((?:.*)\)/
          return nil unless pLine =~ regexExpression
          return pLine.scan(regexExpression)[0].join("")
        end

        def handling_default_parameter(pLine)
          return pLine unless pLine =~ /=/

          partialParameters = split_string_by_comma(pLine)

          newList = []
          partialParameters.each do |element|
            if element =~ /=/
              parameter = element.scan(/(.*)=/).join("").rstrip
              value = element.scan(/=(.*)/).join("").lstrip
              defaultParameter = Hash(parameter => value)
              newList.push(defaultParameter)
              next
            end
            newList.push(element)
          end

          return newList

        end

        def remove_unnecessary_information(pLine)
          if pLine =~ /\(|\)/
            pLine.gsub!(/\(|\)/,"") 
          elsif pLine =~ /\s,|,\s/
            pLine.gsub!(/\s,|,\s/,",")
          else 
            #do nothing to pLine
          end
          return pLine
        end

        def handling_parameter(pLine)
          regexExpression = /\((.+)\)/
          if pLine =~ regexExpression 
            partial = get_parameters(pLine, regexExpression)
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

  # Csharp
  end

# Language
end
