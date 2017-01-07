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
      def common_declaration(pLine)
        line = pLine.dup
        result, hash_of_strings = pre_process(line)
        return {} unless result
        variables = build_hash_of_variables_and_values(result, hash_of_strings)
        variables = normalize_elements(variables)
        return variables
      end

      protected

        # Override
        def replace_strings_and_params(pLine)
          hash_of_string = {}
          # FIXME: it has to handle the case of: method p1, p2
          inside_quotes = /["|']([^["|']]+)["|']|[(]([^[)]]+)[)]/
          pLine.gsub!(inside_quotes).with_index do |match, index|
            hash_of_string["str#{index}"] = match
            match = "<str#{index}>"
          end
          return pLine, hash_of_string
        end

        # Override
        def replace_commas_inside_brackets_and_braces(pLine)
          inside_brackets = /\[\s*([^\]]+)\s*\]/
          pLine = replace_based_on_regex(pLine, inside_brackets)

          inside_braces = /\{\s*([^\}]+)\s*\}/
          pLine = replace_based_on_regex(pLine, inside_braces)
          pLine = replace_based_on_regex(pLine, inside_braces, '=>',
                                         TMP_HASH_SIMBOL)
          return pLine
        end

        # Override
        def replace_equals(pLine)
          find_equal = /[=]/
          # Verify the case of == or ===. Stop immediately
          return nil if pLine =~ /(=)\1/
          # Case of '=' in the beginning
          return nil if pLine =~ /\s*^=/
          pLine.gsub!(find_equal, TMP_TOKEN_EQUAL) if pLine =~ find_equal
          return pLine
        end

        # Override
        def break_string_line(pLine)
          return pLine.split(',')
        end

        # Override
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

        # TODO: Verify if is a keyword
        # Override
        def is_variable?(pVariable)
          return false if pVariable.include?('.')
          return true
        end

        # Override
        def process_value(pValue, pStrings)
          simpleValue = pValue.delete('<>').strip

          return pStrings[simpleValue] if pStrings.has_key?simpleValue

          # TODO: $1 can be dangerous if add parallelization
          # TODO: Think about add space after each replace
          pValue.gsub!(/\s*<(str\d+)>/) {|match| match = pStrings[$1]}

          return pValue
        end

        # Override
        def normalize_elements(pVariables)
          pVariables.each do |key, values|
            values.gsub!(/\s*<comma>\s*/, ',')
            values.gsub!(/\s*<hash>\s*/, '=>')
            values.strip!
            pVariables[key] = values
          end
          return pVariables
        end

      private

        def replace_based_on_regex(pLine, regex, find_to_replace = ',',
                                   replace_by=TMP_TOKEN_COMMA)
          if pLine =~ regex
            pLine.gsub!(regex) {|match| match.gsub(find_to_replace, replace_by)}
          end
          return pLine
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
    #Class
    end
  # Ruby
  end
#Language
end
