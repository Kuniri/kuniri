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
        @whoami = "repetition"
      end

      # @see OOStructuredState
      def conditional_capture
        @language.set_state(@language.conditionalState)
      end

      # @see OOStructuredState
      def repetition_capture
        @language.moreNested
        @language.set_state(@language.repetitionState)
      end

      protected

        def isNestedStructure?(pType)
          if pType == Languages::WHILE_LABEL ||
              pType == Languages::FOR_LABEL ||
              pType == Languages::DO_WHILE_LABEL ||
              pType == Languages::UNTIL_LABEL
            return true
          end
          return false
        end

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
