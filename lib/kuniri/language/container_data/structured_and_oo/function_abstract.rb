require_relative 'basic_data'
require_relative 'conditional_data'
require_relative 'repetition_data'
require_relative 'attribute_data'
require_relative 'manager_basic_structure_data'

module Languages

  # Abstraction for handling function data
  class FunctionAbstract < Languages::BasicData

    public

      attr_reader :parameters
      attr_accessor :type
      attr_reader :managerCondAndLoop

      METHOD_DATA ||= "METHOD"
      CONSTRUCTOR_DATA ||= "CONSTRUCTOR"
      GLOBAL_FUNCTION_DATA ||= "GLOBALFUNCTION"

      def initialize(pFunctionName)
        return nil if pFunctionName.nil? or !pFunctionName.is_a? String

        @name = pFunctionName
        @parameters = []
        @visibility = "public"
        @comments = ""
        @type = "unknown"
        @managerCondAndLoop = Languages::ManagerBasicStructureData.new
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
      def add_conditional(pConditional, pBehaviour = Languages::KEEP_LEVEL)
        return nil unless (pConditional.instance_of?Languages::ConditionalData)
        # XXX: REFECTORY IT! It is ugly
        if pBehaviour == Languages::KEEP_LEVEL
          @managerCondAndLoop.add_conditional(pConditional)
        elsif pBehaviour == Languages::UP_LEVEL
          @managerCondAndLoop.up_level
          @managerCondAndLoop.add_conditional(pConditional)
        elsif pBehaviour == Languages::DOWN_LEVEL
          @managerCondAndLoop.down_level
          @managerCondAndLoop.add_conditional(pConditional)
        end
      end

      # Add repetition element inside function.
      # @param pRepetition An object of RepetitionData.
      # @return If pRepetition is not RepetitionData instance return nil.
      def add_repetition(pRepetition, pBehaviour = Languages::KEEP_LEVEL)
        return nil unless (pRepetition.instance_of?Languages::RepetitionData)
        if pBehaviour == Languages::KEEP_LEVEL
          @managerCondAndLoop.add_repetition(pRepetition)
        elsif pBehaviour == Languages::UP_LEVEL
          @managerCondAndLoop.up_level
          @managerCondAndLoop.add_repetition(pRepetition)
        elsif pBehaviour == Languages::DOWN_LEVEL
          @managerCondAndLoop.down_level
          @managerCondAndLoop.add_repetition(pRepetition)
        end
      end

  # class
  end

# Module
end
