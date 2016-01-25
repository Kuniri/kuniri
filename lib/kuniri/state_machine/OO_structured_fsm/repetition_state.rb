require_relative 'basic_structure_state'
require_relative '../../language/abstract_container/structured_and_oo/global_tokens.rb'

module StateMachine

  module OOStructuredFSM

    # Class responsible for handling Repetition state.
    class RepetitionState < BasicStructureState

      @language

      def initialize(pLanguage)
        @language = pLanguage
        @language.resetNested
        @whoAmI = "repetition"
      end

      protected

        # @see basic_structure_state
        def addBasicStructure(pLine, pFlag, pClassIndex, pElementFile)
          repetition = @language.repetitionHandler.get_repetition(pLine)
          if (repetition)
            addToCorrectElement(repetition, pElementFile, pFlag, pClassIndex)
          end
        end


    # End class
    end

  # End OOStructuredFSM
  end

# End StateMachine
end
