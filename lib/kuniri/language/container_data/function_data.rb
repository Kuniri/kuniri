require_relative 'function'

module Languages

  # Handle function data
  class FunctionData < Languages::Function

    public

      attr_reader :parameters

      def initialize(pFunctionName)
        super(pFunctionName)
        @visibility = "global"
      end

  # class
  end

# Module
end
