require_relative 'function_abstract'

module Languages

  # Handle function data
  class FunctionData < Languages::FunctionAbstract

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
