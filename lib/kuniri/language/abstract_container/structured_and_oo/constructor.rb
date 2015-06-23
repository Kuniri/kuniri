module Languages

  # @abstract Function behavior.
  class Constructor

    public

      # Get constructor in a specific language.
      # @param pLine String with potencial function.
      # @return Return constructor data, or nil if line doesn't have method.
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

      def remove_unnecessary_information(pLine)
        raise NotImplementedError
      end

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
