module Languages

  # @abstract Repetition class handling repetition structures.
  class Repetition

    public

      # Get conditional.
      # @param pLine String with possible repetition statement.
      # @return Return an ConditionalData, otherwise return nil.
      def get_repetition(pLine)
        raise NotImplementedError
      end

    protected

      # Try to detect possible repetition in the line.
      # @param pLine String with possible repetition event.
      # @return Return a partial string, otherwise return nil.
      def detect_repetition(pLine)
        raise NotImplementedError
      end

      # Handling string type
      # @param pString String for find the repetition type.
      # @return Return a string with the type.
      def repetition_type(pString)
        raise NotImplementedError
      end

      # Try to extract the expression.
      # @param pString String with conditional expression.
      # @param pType Loop type.
      # @return Return a partial string.
      def get_expression(pType, pString)
        raise NotImplementedError
      end

      # Take an partial result of string, and remove unnecessary informations.
      # @param pString Line with string.
      # @return Return a string without any unnecessary information.
      def remove_unnecessary_information(pString)
        raise NotImplementedError
      end

  # class
  end

# Languages
end
