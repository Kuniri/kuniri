module Languages

  # @abstract Abstract class for handling attribute.
  class Attribute

    public

      # Verify if a line has an attribute. If it has attribute, firstly, the
      # function capture all lines and removes specific language declaration
      # (for instance, in ruby it is:  "@" or ":" and whitespace), finally
      # it splits the string by an special character and return an object of
      # AttributeData.
      # @param pLine An line to be analysed for find attribute.
      # @return Return on filled object of AttributeData if it find an
      #         attribute, otherwise it returns nil.
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

      # Take the string, and do some final changes on the data before save it.
      # @param pLine Target string to be saved. 
      # @return Returns a final string or array with final attributes.
      def prepare_final_string(pLine)
        raise NotImplementedError
      end

      # Some attributes can be declared in the same line separated only by
      # comma. Here is the place to handling it!
      # @param pString String with all attributes separated by comma.
      # @return Return an array of attributes.
      def handle_multiple_declaration_with_comma(pString)
        raise NotImplementedError
      end

      # Some languages allows do declare and set initial value in the same line
      # by using equal. This method is responsible for handling this kind of
      # situation.
      # @param pString String with multiple declaration of string.
      # @return Return an array of attributes.
      def handle_multiple_declaration_with_equal(pString)
        raise NotImplementedError
      end

      # Handling the simple case of line declaration
      # @param pString String with attribute
      # @return Return an String with the attribute.
      def handle_line_declaration(pString)
        raise NotImplementedError
      end

  # Class
  end

# Language
end
