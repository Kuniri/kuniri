require_relative 'basic_data'
require_relative 'conditional_data'
require_relative 'repetition_data'

module Languages

  # @abstract Function Abstract class responsible to abstract the behavior.
  # Handle function data
  class FunctionAbstract < Languages::BasicData

    public

      attr_reader :parameters
      attr_reader :conditionals
      attr_reader :repetitions

      def initialize(pFunctionName)
        @name = pFunctionName
        @parameters = []
        @conditionals = []
        @repetitions = []
      end

      def add_parameters(pValue)
        # TODO: You have to fix it. 
        @parameters.push(pValue)
      end

      def add_conditional(pConditional)
        return nil unless (pConditional.instance_of?Languages::ConditionalData)
        @conditionals.push(pConditional)
      end

      def add_repetition(pRepetition)
        return nil unless (pConditional.instance_of?Languages::RepetitionData)
        @repetitions.push(pRepetition)
      end

  # class
  end

# Module
end
