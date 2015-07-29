module Languages

  # @abstract Constructor.
  class Constructor

    public

      # Inspect line for trying to find a constructor.
      # @param pLine String with potential function.
      # @return Returns ConstructorData, or nil if line doesn't have method.
      def get_constructor(pLine)
        raise NotImplementedError
      end

    protected

      @type

      # Detect constructor in line
      # @param pLine Line string with the potential constructor inside.
      # @return Return the constructor if it is find in the string, otherwise
      #         return nil
      def detect_constructor(pLine)
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
