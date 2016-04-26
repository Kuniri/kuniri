require_relative 'basic_data'
require_relative 'conditional_data'
require_relative 'repetition_data'
require_relative 'block_data'

module Languages

  # ManagerBasicStructureData Class responsible for management conditionals
  # and repetition.
  class ManagerBasicStructureData < Languages::BasicData

    public

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
      def up_level
        @currentLevel -= 1 if @currentLevel > 0
      end

      # Add nested level, basically, if we have a lot of nested conditional or
      # repetition we add one level for each nest.
      def down_level
        @currentLevel += 1
      end

    private

      @currentLevel

  # End class
  end

# End module
end
