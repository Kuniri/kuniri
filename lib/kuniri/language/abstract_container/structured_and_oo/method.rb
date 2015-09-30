module Languages

  # @abstract Method.
  class Method

    public

      # Inspect line for trying to find a method.
      # @param pLine String with potential method.
      # @return Returns MethodData, or nil if line doesn't have method.
      def get_method(pLine)
        raise NotImplementedError
      end

    protected

      @type

      # Detect method in line
      # @param pLine Line string with the potential method inside.
      # @return Return the method if it is find in the string, otherwise
      #         return nil
      def detect_method(pLine)
        raise NotImplementedError
      end

      # Trim unnecessary information from the string.
      # @param pLine String for handling.
      # @return Return an string.
      def remove_unnecessary_information(pLine)
        raise NotImplementedError
      end

      # Handling default parameters.
      # @param pLine String with parameters.
      # @return Return an array with default parameters.
      def handling_default_parameter(pLine)
        raise NotImplementedError
      end

      # Handling parameters.
      # @param pLine String to try to find the parameters.
      # @return Return a list with all the parameter, otherwise return nil
      def handling_parameter(pLine)
        raise NotImplementedError
      end

  # Class
  end

# Languages
end
