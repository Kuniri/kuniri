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
# TODO: Incomplete
return
        return nil unless result

        result = remove_unnecessary_information(result)
        elements = []

        # Separated by comma, equal or the common case
        if result.scan(/,/).size >= 1
          elements = handle_multiple_declaration_with_comma(result)
        elsif result.scan(/=/).size > 1
          elements = handle_multiple_declaration_with_equal(result)
        else
          elements = handle_line_declaration(result)
        end

        elements.nil? ? nil : normalize_elements(elements)
      end

      protected

        TMP_TOKEN_COMMA = "<comma>"
        TMP_TOKEN_EQUAL = "<equal>"

        # TODO: Make it as a template pattern
        def pre_process(pLine)
          pLine, hash_of_strings = replace_strings(pLine)
          pLine = replace_commas_inside_brackets_and_braces(pLine)
          pLine = replace_equals(pLine)
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
          return pLine
        end

        def replace_based_on_regex(pLine, regex, replace_by=TMP_TOKEN_COMMA)
          if pLine =~ regex
            pLine.gsub!(regex) do |match|
              match.gsub(',', replace_by)
            end
          end
          return pLine
        end

        def replace_equals(pLine)
          find_equal = /[=]/
          if pLine =~ find_equal
            pLine.gsub!(find_equal, TMP_TOKEN_EQUAL)
          end
          return pLine
        end

        def break_string_line(pLine)
          return pLine.split(',')
        end

        # Override
        def detect_variable_element(pLine, pRegex)
          pLine =~ pRegex ? pLine.scan(pRegex).join('') : nil
        end

        # Override
        def normalize_elements(pElements)
          pElements.each_with_index do |element, index|
            pElements.delete_at(index) if is_number?(element.name)
          end
        end

        # Override
        def is_number?(pString)
          true if Float(pString) rescue false
        end

        # Override
        def remove_unnecessary_information(pString)
          pString =~ /\(.*\)/ ? pString.gsub!(/\(.*\)/,'') : pString
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
