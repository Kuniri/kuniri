require_relative 'function_abstract'

module Languages

  # Handle function data
  class FunctionData < Languages::FunctionAbstract

    public

      # Initialize function data based on name.
      # @param pFunctionName name string.
      def initialize(pFunctionName)
        super(pFunctionName)
        @type = GLOBAL_FUNCTION_DATA
      end

  # class
  end

# Module
end
