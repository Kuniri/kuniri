#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

require_relative 'basic_structure_state'
require_relative '../../language/abstract_container/'\
				 'structured_and_oo/global_tokens.rb'

module StateMachine

  module OOStructuredFSM

    # Class responsible for handling Repetition state.
    class RepetitionState < BasicStructureState
      def initialize(pLanguage)
        @language = pLanguage
        @whoAmI = 'repetition'
      end

    end # End class
  end # End OOStructuredFS
end # End StateMachine
