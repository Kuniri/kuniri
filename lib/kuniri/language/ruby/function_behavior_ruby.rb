#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

require_relative '../abstract_container/structured_and_oo/function_behavior'
require_relative '../../core/setting'
require_relative '../container_data/structured_and_oo/function_data'

module Languages

  module Ruby

    # Handling Ruby method
    class FunctionBehaviorRuby < Languages::FunctionBehavior
      # Get Ruby function.
      def get_function(pLine, _type = 'globalFunction')
        result = detect_function(pLine)
        return nil unless result

        functionRuby = Languages::FunctionData.new(result)

        parameters = handling_parameter(pLine)
        parameters&.each do |parameter|
          functionRuby.add_parameters(parameter)
        end
        return functionRuby
      end

      protected

      # Override
      def detect_function(pLine)
        regexExpression = /^\s*def\b\s*(\w*)\b/
        return nil unless pLine =~ regexExpression
        return pLine.scan(regexExpression)[0].join('')
      end

      # Override
      def handling_default_parameter(pLine)
        return pLine unless pLine =~ /=/

        partialParameters = if pLine =~ /,/
                              pLine.split(',')
                            else
                              [pLine]
                            end

        newList = []
        partialParameters.each do |element|
          if element =~ /=/
            parameter = element.scan(/(\w*)=/).join('')
            value = element.scan(/=(\w*)/).join('')
            defaultParameter = { parameter => value }
            newList.push(defaultParameter)
            next
          end
          newList.push(element)
        end

        return newList
      end

      # Override
      def remove_unnecessary_information(pLine)
        return pLine if pLine !~ /\s+|\(|\)/

        nLine = pLine.gsub(/\s+|\(|\)/, '')

        nLine != '' ? nLine : nil
      end

      # Override
      def handling_parameter(pLine)
        # Handling with parenthesis and without it.
        if pLine =~ /\(.*\)/
          partial = get_parameters(pLine, /\(.*\)/)
        elsif pLine =~ /def\s+\w+[\s]+(.+)/
          partial = get_parameters(pLine, /def\s+\w+[\s]+(.+)/)
        else
          return nil
        end

        return handling_default_parameter(partial) if partial =~ /=/
        return split_string_by_comma(partial)
      end

      private

      # Override
      def get_parameters(pLine, pRegex)
        partialParameters = pLine.scan(pRegex).join('')
        partialParameters = remove_unnecessary_information(partialParameters)
        return partialParameters
      end

      # Override
      def split_string_by_comma(pString)
        return pString.split(',') if pString =~ /,/
        return [pString]
      end

    end # Class
  end # Ruby
end # Language
