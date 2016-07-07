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

      protected

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
