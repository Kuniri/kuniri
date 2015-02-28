require_relative '../abstract_container/method.rb'
require_relative '../container_data/method_data.rb'

module Languages

  module Ruby

    # Handling ruby method
    class MethodRuby < Method

      public

        def get_method(pLine)
          result = detect_method(pLine)
          return nil unless result

          methodRuby = Languages::MethodData.new(result)

          parameters = handling_parameter(pLine)
          if parameters
            parameters.each do |parameter|
              methodRuby.add_parameters(parameter)
            end
          end

          return methodRuby
        end

      protected

        def detect_method(pLine)
          regexExpression = /^\s*def\b\s*(\w*)\b/
          return nil unless pLine =~ regexExpression
          return pLine.scan(regexExpression)[0].join("")
        end

        def remove_unnecessary_information(pLine)
          raise NotImplementedError
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

        def handling_parameter(pLine)
          return nil unless pLine =~ /\(.+\)/

          partialParameters = pLine.scan(/\((.+)\)/).join("")
          partialParameters.gsub!(/\s+/, "") if partialParameters =~ /\s+/

          if partialParameters =~ /=/
            return handling_default_parameter(partialParameters)
          end

          return split_string_by_comma(partialParameters)
        end

      private

        def split_string_by_comma(pString)
          return pString.split(",") if pString =~ /,/
          return [pString]
        end

    # Class
    end

  # Ruby
  end

# Language
end
