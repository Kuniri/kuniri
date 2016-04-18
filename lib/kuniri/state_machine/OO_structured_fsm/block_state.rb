require_relative 'basic_structure_state'
require_relative '../../language/abstract_container/structured_and_oo/global_tokens.rb'

module StateMachine

  module OOStructuredFSM

    # Class responsible for handling block state.
    class BlockState < BasicStructureState

      @language

      def initialize(pLanguage)
        @language = pLanguage
        @whoAmI = "block"
      end

      protected

        # @see basic_structure_state
        def addBasicStructure(pLine, pFlag, pClassIndex, pElementFile)
          block = @language.blockHandler.get_blocks(pLine)
          if (block)
            addToCorrectElement(block, pElementFile, pFlag, pClassIndex)
          end
        end

    # End class
    end

  # End OOStructuredFSM
  end

# End StateMachine
end
