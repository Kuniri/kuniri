module Languages

  # @abstract Attribute Abstract class for handling attribute.  
  class Attribute

    # Verify if a line has an attribute. If it has attribute, first the 
    # function capture all lines and remove "@" or ":" and whitespace, finally
    # it splits the string by "," and return an array. Otherwise it returns 
    # nil.
    # @param line to inpect for find attribute.
    # @return Return nil if not find attribute or an array with the attribute.
    def get_attribute(pLine)
      raise NotImplementedError
    end

    protected

      # Detect if line has attribute.
      # @param pLine Line with potential attribute.
      # @return 
      def detect_attribute(pLine)
        raise NotImplementedError
      end

      # Remove unecessary information from line. For example, remove everything
      # into parethesis or line comment.
      # @param pString String for remove unecessary information.
      def remove_unecessary_information(pString)
        raise NotImplementedError
      end

      def prepare_final_string(line)
        raise NotImplementedError
      end

      def handle_multiple_declaration_with_comma(pString)
        raise NotImplementedError
      end

      def handle_multiple_declaration_with_equal(pString)
        raise NotImplementedError
      end

      def handle_line_declaration(pString)
        raise NotImplementedError
      end
  # Class
  end
# Language
end
