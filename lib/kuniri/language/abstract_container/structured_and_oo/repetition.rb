module Languages

  class Repetition

    public

      # Get conditional  
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
      # @return Return a partial string.
      def get_expression(pString)
        raise NotImplementedError
      end

  # class
  end

# Languages
end
