module Languages

  # @abstract This class is an abstraction for handling any element whose the
  # behaviour is similar to a variable. As an example, we have global
  # variables and attributes that have some similarities.
  class VariableBehaviour

    def common_declaration(pLine, pRegex)
      result = detect_variable_element(pLine, pRegex)
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

      def detect_variable_element(pLine, pRegex)
        pLine =~ pRegex ? pLine.scan(pRegex).join('') : nil
      end

      # Sometimes, Kuniri has handling expressions like 'xpto = lalala = 7' and
      # treat 7 like a variable name. Hence, a normalize function is required
      # because it removes this kind of problem.
      # @param pElements Reference to an array to change.
      def normalize_elements(pElements)
        pElements.each_with_index do |element, index|
          pElements.delete_at(index) if is_number?(element.name)
        end
      end

      def is_number?(pString)
        true if Float(pString) rescue false
      end

      # Remove unnecessary information from line. For example, remove
      # everything into parenthesis or line comment.
      # @param pString String for remove unnecessary information.
      # @return If match any unnecessary character defined by the programmer
      #         returns the new string, otherwise return the same string.
      def remove_unnecessary_information(pString)
        raise NotImplementedError
      end

      # Prepare final string, before save it in a container data.
      # @param pLine Line to be inspected.
      # @return Return a string.
      def prepare_final_string(pLine)
        raise NotImplementedError
      end

      # One common behaviour related with variables, is the multiple
      # declaration separated by comma. This method is responsible for
      # handling multiple line declaration separated by comma.
      # @param pString String to be handled.
      # @return Return an array with multiple variables.
      def handle_multiple_declaration_with_comma(pString)
        raise NotImplementedError
      end

      # Handling multiple declaration with equal.
      # @param pString String with multiple declaration.
      # @return Return an string.
      def handle_multiple_declaration_with_equal(pString)
        raise NotImplementedError
      end

      # Handling line declaration.
      # @param pString Line with simple declaration.
      # @return Return a string.
      def handle_line_declaration(pString)
        raise NotImplementedError
      end

      def handle_multiple_declaration
        raise NotImplementedError
      end

      def handle_value(pString)
        raise NotImplementedError
      end
  # Class
  end
# Language
end
