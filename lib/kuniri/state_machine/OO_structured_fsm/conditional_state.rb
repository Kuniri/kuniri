require_relative 'basic_structure_state'
require_relative '../../language/abstract_container/structured_and_oo/global_tokens.rb'

module StateMachine

  module OOStructuredFSM

    # Class responsible for handling Repetition state.
    class ConditionalState < BasicStructureState

      @language

      def initialize(pLanguage)
        @language = pLanguage
        @language.resetNested
        @whoami = "conditional"
      end

      # @see OOStructuredState
      def repetition_capture
        @language.set_state(@language.repetitionState)
      end

      # @see OOStructuredState
      def conditional_capture
        @language.moreNested
        @language.set_state(@language.conditionalState)
      end

      protected

        def isNestedStructure?(pType)
          if pType == Languages::IF_LABEL || pType == Languages::CASE_LABEL ||
              pType == Languages::UNLESS_LABEL
            return true
          end
          return false
        end

        def addBasicStructure(pLine, pFlag, pClassIndex, pElementFile)
          conditional = @language.conditionalHandler.get_conditional(pLine)
          if (conditional)
            addToCorrectElement(conditional, pElementFile, pFlag, pClassIndex)
          end
        end

    # End class
    end

  # End OOStructuredFSM
  end

# End StateMachine
end
