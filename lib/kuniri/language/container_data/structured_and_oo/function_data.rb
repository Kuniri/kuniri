require_relative 'function_abstract'

module Languages

  # Handle function data
  class FunctionData < Languages::FunctionAbstract

    public

      attr_reader :parameters

      def initialize(pFunctionName)
        return nil if pFunctionName.nil? or !pFunctionName.is_a? String

        super(pFunctionName)
        @visibility = "global"
      end

  # class
  end

# Module
end
