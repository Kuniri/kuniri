module Languages

  # @abstract Function behavior.
  class FunctionBehavior

    public

      # ...
      # @param pLine String with potencial function.
      # @return Return function data, or nil if line doesn't have method.
      def get_function(pLine)
        raise NotImplementedError
      end

    protected

      # Detect function in line
      # @param pLine Line string with the potential method inside.
      # @return Return the method if it is find in the string, othewise return 
      #   nil
      def detect_function(pLine)
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
      # @return Return a list with all the parameter, othewise return nil
      def handling_parameter(pLine)
        raise NotImplementedError
      end

  # Class
  end

# Languages
end
