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
          access_regex = /private|public|protected/
          modifier_regex = /\sstatic|\svirtual|\ssealed/
          regexExpression = /^\s?(?:\w+)\s(\w+)\s?\((?:.*)\)\s?(?:{|})?/
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
          if pLine =~ /\(|\)/
            pLine.gsub!(/\(|\)/,"") 
          elsif pLine =~ /,\s/
            pLine.gsub!(/,\s/,",")
          else 
            #do nothing to pLine
          end
          return pLine
        end

        def handling_parameter(pLine)
          access_regex = /private|public|protected/
          modifier_regex = /\sstatic|\svirtual|\ssealed/
          regexExpression = /^\s?(?:#{access_regex})(?:#{modifier_regex})?\s(?:\w+)\s(?:\w+)\s?\((.*)\)\s?(?:{|})?/
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
          return pString.split(",") if pString =~ /,/
          return [pString]
        end
    # Class
    end

  # Csharp
  end

# Language
end
