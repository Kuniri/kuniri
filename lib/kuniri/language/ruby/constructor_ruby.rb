require_relative '../abstract_container/structured_and_oo/constructor'
require_relative '../container_data/structured_and_oo/constructor_data'

module Languages

  module Ruby

    # Handling ruby constructor
    class ConstructorRuby < Languages::Constructor

      public

        def get_constructor(pLine, type = 'globalFunction')
          result = detect_constructor(pLine)
          return nil unless result

          constructorRuby = Languages::ConstructorData.new(result)

          parameters = handling_parameter(pLine)
          if parameters
            parameters.each do |parameter|
              constructorRuby.add_parameters(parameter)
            end
          end

          return constructorRuby
        end

      protected

        def detect_constructor(pLine)
          regexExpression = /^\s*def\b\s*(\w*)\b/
          return nil unless pLine =~ regexExpression
          preProcessed = pLine.scan(regexExpression)[0].join("")
          return nil unless preProcessed =~ /initialize/
          return preProcessed
        end

        def handling_default_parameter(pLine)
          return pLine unless pLine =~ /=/

          if (pLine =~ /,/)
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

  # Ruby
  end

# Language
end
