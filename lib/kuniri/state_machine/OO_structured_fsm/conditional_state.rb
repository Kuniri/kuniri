require_relative 'basic_structure_state'
require_relative '../../language/abstract_container/structured_and_oo/global_tokens.rb'

module StateMachine

  module OOStructuredFSM

    # Class responsible for handling Conditional state.
    class ConditionalState < BasicStructureState

      @language

      def initialize(pLanguage)
        @language = pLanguage
        @whoAmI = "conditional"
      end

      protected

        # @see basic_structure_state
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
