require_relative 'basic_data'

module Languages

  # @abstract Function Abstract class responsible to abstract the behavior.
  # Handle function data
  class Function < Languages::BasicData

    public

      attr_reader :parameters

      def initialize(pFunctionName)
        @name = pFunctionName
        @parameters = []
      end

      def add_parameters(pValue)
        # TODO: You have to fix it. 
        @parameters.push(pValue)
      end

  # class
  end

# Module
end
