require_relative '../abstract_container/structured_and_oo/variable_behaviour'

module Languages

  module Ruby

    # Ruby Handling Ruby attributes
    class VariableBehaviourRuby < Languages::VariableBehaviour

      protected

        # Override
        def remove_unnecessary_information(pString)
          return pString.gsub!(/\(.*\)/,"") if pString =~ /\(.*\)/
          return pString
        end

        # Override
        def prepare_final_string(pString)
          if pString =~ /\s+|:|@|=/
            return pString.gsub!(/\s+|:|@|=/,"")
          end
          return pString
        end

        # Override
        def handle_multiple_declaration_with_comma(pString)
          listOfAttributes = []
          pString = pString.split(",")
          pString.each do |variable|
            return nil if variable.scan(/=/).count > 1

            variable = variable.scan(/.*=/).join("") if variable =~ /.*=/

            return nil if variable =~ /\./

            variable = prepare_final_string(variable)
            finalVariableElement = yield(variable)
            listOfAttributes.push(finalVariableElement)
          end

          return listOfAttributes
        end

        # Override
        def handle_multiple_declaration_with_equal(pString)
          listOfAttributes = []
          pString = pString.split("=")
          pString.each do |variable|
            return nil if variable =~ /\./

            variable = prepare_final_string(variable)
            attribute = yield(variable)
            listOfAttributes.push(attribute)
          end

          return listOfAttributes
        end

        # Override
        def handle_line_declaration(pString)
          listOfAttributes = []
          if pString =~ /=/
            pString = pString.scan(/.*=/).join("")
            return nil if pString =~ /\./
          end

          return nil if pString =~ /\./

          pString = prepare_final_string(pString)
          attribute = yield(pString)
          listOfAttributes.push(attribute)

          return listOfAttributes
        end

    #Class
    end

  # Ruby
  end
#Language
end
