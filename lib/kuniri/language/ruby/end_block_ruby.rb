#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

require_relative '../abstract_container/structured_and_oo/end_block'

module Languages

  module Ruby

    # Class responsible for handling Ruby end of block.
    class EndBlockRuby < Languages::EndBlock

      public

        # Verify Ruby end of block.
        # @see EndBlock
        def end_of_block?(pLine)
          return detect_end(pLine)
        end

      protected

        def detect_end(pLine)
          #TODO: EXTREMELY SIMPLE HANDLING, IT HAVE TO BE IMPROVED!
          return true if pLine =~ /^\s+end|^end|\send;?$/
          return false
        end

    # Class
    end

  # Module
  end

# Module
end
