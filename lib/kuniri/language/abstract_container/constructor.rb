require_relative 'function_behavior'

module Languages

  # @abstract Method Abstract class for handling constructor.
  class Constructor < Languages::FunctionBehavior

    public

      # Based on the line, verify if line has a constructor and return it.
      # @param pLine String with potencial constructor.
      # @return Return a Method class, or nil if line doesn't have constructor.
      def get_constructor(pLine)
        get_function(pLine)
      end

  # Class
  end

# Languages
end
