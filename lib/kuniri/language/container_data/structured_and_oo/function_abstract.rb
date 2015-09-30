require_relative 'basic_data'
require_relative 'conditional_data'
require_relative 'repetition_data'
require_relative 'attribute_data'

module Languages

  # Abstraction for handling function data
  class FunctionAbstract < Languages::BasicData

    public

      attr_reader :parameters
      attr_reader :conditionals
      attr_reader :repetitions
      attr_accessor :type

      METHOD_DATA ||= "METHOD"
      CONSTRUCTOR_DATA ||= "CONSTRUCTOR"
      GLOBAL_FUNCTION_DATA ||= "GLOBALFUNCTION"

      def initialize(pFunctionName)
        @name = pFunctionName
        @parameters = []
        @conditionals = []
        @repetitions = []
        @visibility = "public"
        @comments = ""
        @type = "unknown"
      end

      # Add parameters inside function.
      # @param pValue Add a parameter inside function.
      # @return if pValue is not String or Hash with more than one element.
      #         return nil.
      def add_parameters(pValue)
        unless ((pValue.is_a? Hash and pValue.length == 1) or
                 pValue.is_a? String)
          return nil
        end
        @parameters.push(pValue)
      end

      # Add conditional element inside function.
      # @param pConditional An object of ConditionalData.
      # @return If pConditional is not an instance of ConditionalData,
      #         return nil.
      def add_conditional(pConditional)
        return nil unless (pConditional.instance_of?Languages::ConditionalData)
        @conditionals.push(pConditional)
      end

      # Add repetition element inside function.
      # @param pRepetition An object of RepetitionData.
      # @return If pRepetition is not RepetitionData instance return nil.
      def add_repetition(pRepetition)
        return nil unless (pRepetition.instance_of?Languages::RepetitionData)
        @repetitions.push(pRepetition)
      end

  # class
  end

# Module
end
