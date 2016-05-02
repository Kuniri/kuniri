require_relative '../abstract_container/structured_and_oo/variable_global'
require_relative '../container_data/structured_and_oo/variable_global_data'

module Languages

  module Ruby

    # VariableGlobalRuby Handling extern requirements.
    class VariableGlobalRuby < Languages::VariableGlobal

      public

        # Get Ruby variable.
        # @see Languages::VariableGlobal
        def get_variable(pLine)
          result = detect_variable(pLine)
          return nil unless result

          listOfVariable = []

          # Separated by comma, equal or the common case
          if result.split(",").size > 1
            listOfVariable = handle_multiple_declaration_with_comma(result)
          elsif result.split("=").size > 2
            listOfVariable = handle_multiple_declaration_with_equal(result)
          else
            listOfVariable = handle_line_declaration(result)
          end

          return listOfVariable
        end

      protected

        # Override
        def detect_variable(pLine)
          # Check basic case of non variable. Ex.: value x
          pLine.gsub!(/^\s*/, "")
          pLine.gsub!(/\s*$/, "")
          return nil if pLine =~ /end/
          return nil if pLine =~ /^def\s+/
          return nil if pLine =~ /=begin/
          return pLine if pLine.split(",").size > 1
          return pLine if pLine.split("=").size > 1

          return nil if pLine.split(" ").size > 1
          return pLine
        end

        # Override
        def remove_unnecessary_information(pLine)
          return pLine
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
          listOfVariable = []
          pString = pString.split(",")
          pString.each do |variable|
            return nil if variable.split("=").size > 2
            value = 'nothing'
            if variable =~ /=/
              value = handle_value(variable)
              variable = variable.scan(/.*=/).join("")
              return nil if pString =~ /\./
            end
            return nil if variable =~ /\./

            variable = prepare_final_string(variable)
            globalVariable = Languages::VariableGlobalData.new(variable)
            globalVariable.value = value
            listOfVariable.push(globalVariable)
          end

          return listOfVariable
        end

        # Override
        def handle_multiple_declaration_with_equal(pString)
          listOfVariable = []
          pString = pString.split("=")
          value = handle_value(pString.last)
          pString.each do |variable|
            return nil if variable =~ /\./

            variable = prepare_final_string(variable)
            globalVariable = Languages::VariableGlobalData.new(variable)
            globalVariable.value = value
            listOfVariable.push(globalVariable)
          end
          value = listOfVariable.pop

          return listOfVariable
        end

        # Override
        def handle_line_declaration(pString)
          listOfVariable = []
          value = 'nothing'
          if pString =~ /=/
            value = handle_value(pString)
            pString = pString.scan(/.*=/).join("")
            return nil if pString =~ /\./
          end

          return nil if pString =~ /\./

          pString = prepare_final_string(pString)
          globalVariable = Languages::VariableGlobalData.new(pString)
          globalVariable.value = value
          listOfVariable.push(globalVariable)

          return listOfVariable
        end

        def handle_value(pString)
          value = pString
          value = pString.scan(/=(.*)/).join("") if pString =~ /=/
          value = value.lstrip
          value = value.rstrip
          value = value.gsub(/'|\"/,"")
          return value
        end

    # Class
    end

  # Module
  end

# Module
end
