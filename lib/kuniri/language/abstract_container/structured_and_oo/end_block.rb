#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

module Languages

  # @abstract Class responsible for handling end block of each language.
  class EndBlock

    public

      # Verify if line has an end of line token.
      # @param pLine Line to inspect.
      # @return Return true if find an end block, otherwise return false.
      def has_end_of_block?(pLine)
        raise NotImplementedError
      end

    protected

      # Keeps some operation for find line.
      # @param pLine Line with potential end of block.
      def detect_end(pLine)
        raise NotImplementedError
      end

  # End block
  end

# End module
end
