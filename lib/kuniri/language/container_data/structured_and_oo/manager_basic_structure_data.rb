require_relative 'basic_data'

module Languages

  # ManagerBasicStructureData Class responsible for management conditionals
  # and repetition.
  class ManagerBasicStructureData < Languages::BasicData

    public

      attr_accessor :basicStructure

      # Add conditional to basicStructure
      # @param pConditional ConditionalData to add inside basicStructure
      def add_conditional(pConditional)
        # TODO
      end

      # Add repetition to basicStructure
      # @param pRepetition RepetitionData to add inside basicStrure
      def add_repetition(pRepetition)
        # TODO
      end

      # Up current level
      def up_level
        # TODO
      end

      # Add nested level, basically, if we have a lot of nested conditional or
      # repetition we add one level for each nest.
      def down_level
        # TODO
      end

  # End class
  end

# End module
end
