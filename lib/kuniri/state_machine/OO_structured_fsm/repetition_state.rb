require_relative 'basic_structure_state'
require_relative '../../language/abstract_container/structured_and_oo/global_tokens.rb'

module StateMachine

  module OOStructuredFSM

    # Class responsible for handling Repetition state.
    class RepetitionState < BasicStructureState

      @language

      def initialize(pLanguage)
        @language = pLanguage
        @whoAmI = 'repetition'
      end

    # End class
    end

  # End OOStructuredFSM
  end

# End StateMachine
end
