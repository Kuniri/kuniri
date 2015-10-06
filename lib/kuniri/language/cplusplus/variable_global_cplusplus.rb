require_relative '../abstract_container/structured_and_oo/variable_global'
require_relative '../container_data/structured_and_oo/variable_global_data'

module Languages

  module Cplusplus

    # @class VariableGlobalCplusplus Handling extern requirements.
    class VariableGlobalCplusplus < Languages::VariableGlobal

      public

        def get_variable(pLine)
          result = detect_variable(pLine)
          return nil unless result

          listOfVariable = []

          # Separated by comma, equal or the common case
          if result.split(",").size > 1
            listOfVariable = handle_multiple_declaration_with_comma(result)
          elsif result.split("=").size > 1
            listOfVariable = handle_multiple_declaration_with_equal(result)
          else
            listOfVariable = handle_line_declaration(result)
          end

          return listOfVariable
        end

      protected

        def detect_variable(pLine)
          # Check basic case of non variable. Ex.: value x
          pLine.gsub!(/^\s*/, "")
          pLine.gsub!(/\s*$/, "")
          return nil if pLine =~ /end/
          return nil if pLine =~ /^def\s+/
          return pLine if pLine.split(",").size > 1
          return pLine if pLine.split("=").size > 1

          return nil if pLine.split(" ").size > 1
          return pLine
        end

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

            variable = variable.scan(/.*=/).join("") if variable =~ /.*=/

            return nil if variable =~ /\./

            variable = prepare_final_string(variable)
            globalVariable = Languages::VariableGlobalData.new(variable)
            listOfVariable.push(globalVariable)
          end

          return listOfVariable
        end

        # Override
        def handle_multiple_declaration_with_equal(pString)
          listOfVariable = []
          pString = pString.split("=")
          pString.each do |variable|
            return nil if variable =~ /\./

            variable = prepare_final_string(variable)
            globalVariable = Languages::VariableGlobalData.new(variable)
            listOfVariable.push(globalVariable)
          end
          value = listOfVariable.pop

          return listOfVariable
        end

        # Override
        def handle_line_declaration(pString)
          listOfVariable = []
          if pString =~ /=/
            pString = pString.scan(/.*=/).join("")
            return nil if pString =~ /\./
          end

          return nil if pString =~ /\./

          pString = prepare_final_string(pString)
          globalVariable = Languages::VariableGlobalData.new(pString)
          listOfVariable.push(globalVariable)

          return listOfVariable
        end


    # Class
    end

  # Cplusplus
  end

# Module
end
