require_relative 'basic_data'

module Languages

  # Handle function data
  class FunctionData < BasicData

    public

      attr_reader :parameters

      def initialize(pFunctionName)
        @name = pFunctionName
      end

      def add_parameters(pValue)
        # TODO: You have to fix it. 
        @parameters.push(pValue)
      end

  # class
  end

# Module
end
