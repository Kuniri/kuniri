#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

require_relative 'basic_data'
require_relative 'conditional_data'
require_relative 'repetition_data'
require_relative 'block_data'

module Languages

  # ManagerBasicStructureData Class responsible for management conditionals
  # and repetition.
  class ManagerBasicStructureData < Languages::BasicData

    attr_accessor :basicStructure

    def initialize
      @basicStructure = []
      @currentLevel = 0
    end

    # Add conditional to basicStructure
    # @param pConditional ConditionalData to add inside basicStructure
    def add_conditional(pConditional)
      return nil unless pConditional.is_a?(Languages::ConditionalData)
      pConditional.level = @currentLevel
      @basicStructure.push(pConditional)
    end

    # Add repetition to basicStructure
    # @param pRepetition RepetitionData to add inside basicStrure
    def add_repetition(pRepetition)
      return nil unless pRepetition.is_a?(Languages::RepetitionData)
      pRepetition.level = @currentLevel
      @basicStructure.push(pRepetition)
    end

    # Add block to basicStructure
    # @param pBlock BlockData to add inside basicStructure
    def add_block(pBlock)
      return nil unless pBlock.is_a?(Languages::BlockData)
      pBlock.level = @currentLevel
      @basicStructure.push(pBlock)
    end

    # Up current level
    def decrease_deep_level
      @currentLevel -= 1 if @currentLevel.positive?
    end

    # Add nested level, basically, if we have a lot of nested conditional or
    # repetition we add one level for each nest.
    def increase_deep_level
      @currentLevel += 1
    end
  end # End class
end # End module
