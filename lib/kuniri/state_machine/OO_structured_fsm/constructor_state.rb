#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

require_relative 'oo_structured_state'
require_relative 'token_state_machine'
require_relative 'function_behaviour_state'

module StateMachine

  module OOStructuredFSM

    # Class responsible for handling constructor state.
    class ConstructorState < FunctionBehaviourState

      def initialize(pLanguage)
        super(
          pLanguage,
          flagState: StateMachine::CONSTRUCTOR_STATE,
          functionId: StateMachine::CONSTRUCTOR_LABEL
        )
      end

    # End class
    end

  # End OOStructuredFSM
  end

# End StateMachine
end
