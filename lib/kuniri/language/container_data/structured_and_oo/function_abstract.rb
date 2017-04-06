#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

require_relative 'basic_data'
require_relative 'conditional_data'
require_relative 'repetition_data'
require_relative 'attribute_data'
require_relative 'block_data'
require_relative 'manager_basic_structure_data'

module Languages

  # Abstraction for handling function data
  class FunctionAbstract < Languages::BasicData

    attr_reader :parameters
    attr_accessor :type
    attr_reader :managerCondLoopAndBlock

    METHOD_DATA ||= 'METHOD'.freeze
    CONSTRUCTOR_DATA ||= 'CONSTRUCTOR'.freeze
    GLOBAL_FUNCTION_DATA ||= 'GLOBALFUNCTION'.freeze

    def initialize(pFunctionName)
      return nil if pFunctionName.nil? || !pFunctionName.respond_to?(:to_str)

      @name = pFunctionName
      @parameters = []
      @visibility = 'public'
      @comments = ''
      @type = 'unknown'
      @managerCondLoopAndBlock = Languages::ManagerBasicStructureData.new
    end

    # Add parameters inside function.
    # @param pValue Add a parameter inside function.
    # @return if pValue is not String or Hash with more than one element.
    #         return nil.
    def add_parameters(pValue)
      unless ((pValue.respond_to?(:has_key?) && pValue.length == 1) ||
               pValue.respond_to?(:to_str))
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
      add_with_manager(pConditional, 'conditional', pBehaviour)
    end

    # Add repetition element inside function.
    # @param pRepetition An object of RepetitionData.
    # @return If pRepetition is not RepetitionData instance return nil.
    def add_repetition(pRepetition, pBehaviour = Languages::KEEP_LEVEL)
      return nil unless (pRepetition.instance_of?Languages::RepetitionData)
      add_with_manager(pRepetition, 'repetition', pBehaviour)
    end

    # Add block element inside function.
    # @param pBlock An object of BlockData.
    # @return If pBlock is not pBlockData instance return nil.
    def add_block(pBlock, pBehaviour = Languages::KEEP_LEVEL)
      return nil unless (pBlock.instance_of?Languages::BlockData)
      add_with_manager(pBlock, 'block', pBehaviour)
    end

    # Copy elements from an object of FunctionAbstract to specific element
    # @param fromTo Reference from FunctionAbstract
    def <<(fromTo)
      return nil unless fromTo.is_a?(Languages::FunctionAbstract)
      @name = fromTo.name
      @parameters = fromTo.parameters
      @managerCondLoopAndBlock = fromTo.managerCondLoopAndBlock
      @visibility = fromTo.visibility
      @comments = fromTo.comments
      @type = @type
    end

    private

    # Add to a manager conditional or repetition.
    # @param pElementToAdd Element wish we want to add.
    # @param pMetaData String with name for of element we want to add.
    # @param pBehaviour Flag with behaviour.
    def add_with_manager(pElementToAdd, pMetaData, pBehaviour)
      case pBehaviour
      when Languages::KEEP_LEVEL
        @managerCondLoopAndBlock.send("add_#{pMetaData}", pElementToAdd)
      when Languages::UP_LEVEL
        @managerCondLoopAndBlock.decrease_deep_level
        @managerCondLoopAndBlock.send("add_#{pMetaData}", pElementToAdd)
      when Languages::DOWN_LEVEL
        @managerCondLoopAndBlock.increase_deep_level
        @managerCondLoopAndBlock.send("add_#{pMetaData}", pElementToAdd)
      end
    end
  end # class
end # Module
