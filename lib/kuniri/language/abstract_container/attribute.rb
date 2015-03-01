module Languages

  # @abstract Attribute Abstract class for handling attribute.
  class Attribute

    public

      # Verify if a line has an attribute. If it has attribute, first the
      # function capture all lines and removes specific language declaration
      # (for instance, in ruby it is:  "@" or ":" and whitespace), finally
      # it splits the string by an special character and return an 
      # AttributeData
      # array. Otherwise it return nil.
      # @param line to inspect for find attribute.
      # @return Return nil if not find attribute or an array with the 
      #         attribute.
      def get_attribute(pLine)
        raise NotImplementedError
      end

    protected

      # Detect if line has attribute.
      # @param pLine Line with potential attribute.
      # @return Return a matched STRING or nil if not found.
      def detect_attribute(pLine)
        raise NotImplementedError
      end

      # Remove unnecessary information from line. For example, remove
      # everything into parenthesis or line comment.
      # @param pString String for remove unnecessary information.
      # @return If match any unnecessary character defined by the programmer
      #         returns the new string, otherwise return the same string.
      def remove_unnecessary_information(pString)
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
