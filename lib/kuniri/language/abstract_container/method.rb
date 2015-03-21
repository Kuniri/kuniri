require_relative 'function_behavior'

module Languages

  # @abstract Method Abstract class for handling method
  class Method < Languages::FunctionBehavior

    public

      # Based on the line, verify if line has a method and return it.
      # @param pLine String with potencial method.
      # @return Return a Method class, or nil if line doesn't have method.
      def get_method(pLine)
        get_function(pLine)
      end

    protected

      # Detect method in line
      # @param pLine Line string with the potential method inside.
      # @return Return the method if it is find in the string, othewise return 
      #   nil
      def detect_method(pLine)
        detect_function(pLine)
      end

  # Class
  end

# Languages
end
