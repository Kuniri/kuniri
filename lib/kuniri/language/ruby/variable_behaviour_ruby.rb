require_relative '../abstract_container/structured_and_oo/variable_behaviour'
require_relative '../container_data/structured_and_oo/attribute_data'
require_relative '../container_data/structured_and_oo/variable_global_data'

module Languages

  module Ruby

    # Ruby Handling Ruby attributes
    class VariableBehaviourRuby < Languages::VariableBehaviour

      def initialize(pWhoAmIHelping)
        @whoAmIHelping = pWhoAmIHelping
      end

      # Override
      def common_declaration(pLine, pRegex)
        result, hash_of_strings = pre_process(pLine)
        return {} unless result
        variables = build_hash_of_variables_and_values(result, hash_of_strings)
        variables = normalize_elements(variables)

        return variables
      end

      protected

        TMP_TOKEN_COMMA = "<comma>"
        TMP_TOKEN_EQUAL = "<equal>"
        TMP_HASH_SIMBOL = "<hash>"

        # TODO: Make it as a template pattern
        def pre_process(pLine)
          pLine, hash_of_strings = replace_strings(pLine)
          pLine = replace_commas_inside_brackets_and_braces(pLine)
          pLine = replace_equals(pLine)
          return nil, nil unless pLine # Case of ==, stop immediately
          pLine = break_string_line(pLine)
          return pLine, hash_of_strings
        end

        def replace_strings(pLine)
          hash_of_string = {}
          inside_quotes = /["|']([^["|']]+)["|']/
          pLine.gsub!(inside_quotes).with_index do |match, index|
            hash_of_string["str#{index}"] = match
            match = "<str#{index}>"
          end
          return pLine, hash_of_string
        end

        def replace_commas_inside_brackets_and_braces(pLine)
          inside_brackets = /\[([^\]]+)\]/
          pLine = replace_based_on_regex(pLine, inside_brackets)

          inside_braces = /\{([^\}]+)\}/
          pLine = replace_based_on_regex(pLine, inside_braces)
          pLine = replace_based_on_regex(pLine, inside_braces, '=>',
                                         TMP_HASH_SIMBOL)
          return pLine
        end

        def replace_based_on_regex(pLine, regex, find_to_replace = ',',
                                   replace_by=TMP_TOKEN_COMMA)
          if pLine =~ regex
            pLine.gsub!(regex) {|match| match.gsub(find_to_replace, replace_by)}
          end
          return pLine
        end

        def replace_equals(pLine)
          find_equal = /[=]/
          # Verify the case of == or ===. Stop immediately
          return nil if pLine =~ /(=)\1/
          pLine.gsub!(find_equal, TMP_TOKEN_EQUAL) if pLine =~ find_equal
          return pLine
        end

        def break_string_line(pLine)
          return pLine.split(',')
        end

        def build_hash_of_variables_and_values(pVariablesList, pStringsValues)
          variables = {}
          pVariablesList.each do |var_candidate|
            if var_candidate.include?(TMP_TOKEN_EQUAL)
              variables.merge!(handle_equals(var_candidate, pStringsValues))
            else
              # TODO: Remove 'nothing' and put it in a token class
              if is_variable?(var_candidate)
                variables[var_candidate.strip] = 'nothing'
              end
            end
          end
          return variables
        end

        def handle_equals(pStringWithVariables, pStrings)
          variables = {}
          partialVariable = pStringWithVariables.split(TMP_TOKEN_EQUAL)
          value = partialVariable.pop
          value = process_value(value, pStrings)
          if partialVariable.size >= 2
            partialVariable.each do |var|
              next unless is_variable?(var)
              variables[var.strip] = value
            end
          else
            if is_variable?(partialVariable.first)
              variables[partialVariable.first.strip] = value
            end
          end
          return variables
        end

        # TODO: Verify if is a keyword
        def is_variable?(pVariable)
          return false if pVariable.include?('.')
          return true
        end

        def process_value(pValue, pStrings)
          simpleValue = pValue.delete('<>').strip

          return pStrings[simpleValue] if pStrings.has_key?simpleValue

          if pValue =~ /\{([^\}]+)\}/
            # TODO: $1 can be dangerous if add parallelization
            pValue.gsub!(/\s*<(str\d+)>/) {|match| match = pStrings[$1]}
          end

          return pValue
        end

#TODO: Death code! Remove it.
        # Override
        def normalize_elements(pVariables)
          pVariables.each do |key, values|
            newKey = remove_unnecessary_information(key)
            pVariables[newKey] = values
            pVariables.delete(key)
          end
          return pVariables
        end

        # Override
        def remove_unnecessary_information(pString)
          return pString.lstrip.rstrip
        end

        # Override
        def detect_variable_element(pLine, pRegex)
          pLine =~ pRegex ? pLine.scan(pRegex).join('') : nil
        end

        # Override
        def is_number?(pString)
          true if Float(pString) rescue false
        end

        # Override
        def prepare_final_string(pString)
          regex = /\s+|:|@|=/
          pString =~ regex ? pString.gsub!(regex,'') : pString
        end

        # Override
        def handle_multiple_declaration_with_comma(pString)
          return handle_multiple_declaration(pString, ',') do |variable|
            variable = variable.scan(/.*=/).join('') if variable =~ /.*=/
            variable
          end
        end

        # Override
        def handle_multiple_declaration_with_equal(pString)
          tmp  = pString.split('=')
          value = 'nothing'
          value = handle_value(tmp.last)
          return handle_multiple_declaration(pString, '=', value){ |variable| variable }
        end

        # Override
        def handle_line_declaration(pString)
          value = 'nothing'
          value = handle_value(pString) if pString =~ /=/
          return handle_line(pString, value){ |pString| pString }
        end

        def handle_multiple_declaration(pString, pSplitChar, value = 'nothing')
          listOfAttributes = []
          pString = pString.split(pSplitChar)

          pString.each do |variable|
            if pSplitChar == '='
              attribute = handle_line(variable, value) { |pString| yield(pString) }
            else
              attribute = handle_line(variable) { |pString| yield(pString) }
            end
            listOfAttributes.concat(attribute) if attribute
          end
          return listOfAttributes
        end

        def handle_line(pString, value = 'nothing')
          if pString =~ /=/
            value = handle_value(pString)
            pString = pString.scan(/.*=/).join('')
            return nil if pString =~ /\./
          end

          pString = yield(pString)

          return nil if pString =~ /\./

          pString = prepare_final_string(pString)
          # We can make it generic
          attribute = eval("Languages::#{@whoAmIHelping}Data.new(pString)")
          attribute.value = value

          return [attribute]
        end

        def handle_value(pString)
          value = pString
          value = pString.scan(/=(.*)/).join('') if pString =~ /=/
          value = value.lstrip
          value = value.rstrip
          value = value.gsub(/'|\"/,'')
          return value
        end
    #Class
    end
  # Ruby
  end
#Language
end
