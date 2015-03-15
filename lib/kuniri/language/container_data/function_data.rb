require_relative 'basic_data'

module Languages

  # Handle function data
  class FunctionData < Languages::BasicData

    public

      attr_reader :parameters

      def initialize(pFunctionName)
        @name = pFunctionName
        @parameters = []
        @visibility = "global"
      end

      def add_parameters(pValue)
        # TODO: You have to fix it. 
        @parameters.push(pValue)
      end

  # class
  end

# Module
end
