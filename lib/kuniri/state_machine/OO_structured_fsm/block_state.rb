#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

require_relative 'basic_structure_state'
require_relative '../../language/abstract_container/structured_and_oo/global_tokens.rb'

module StateMachine

  module OOStructuredFSM

    # Class responsible for handling block state.
    class BlockState < BasicStructureState
      def initialize(pLanguage)
        @language = pLanguage
        @whoAmI = 'block'
      end

    end # End class
  end # End OOStructuredFSM
end # End StateMachine
