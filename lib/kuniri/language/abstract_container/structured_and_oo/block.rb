#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

module Languages

  # @abstract Class responsible for handling block.
  class Block
    # Verify if a line has an block. If it has block, firstly, the
    # function capture all lines.
    # @param pLine An line to be analysed for find block.
    # @return Return on filled object of BlockData if it find an
    #         block, otherwise it returns nil.
    def get_block(_pLine)
      raise NotImplementedError
    end

    protected

    # Method with a regex to check if line has a block.
    # @param pLine String with potential block inside.
    # @return Partial string with detection, otherwise return nil.
    def detect_block(_pLine)
      raise NotImplementedError
    end

    # Set the name of the block based on the name captured.
    # Note: If this method is executed, we suppose we already have a block
    # as a string.
    # @param pString Partial string to be handled.
    # @return String with block name in uppercase.
    def capture_block_name(_pString)
      raise NotImplementedError
    end

    # Extract expression from the captured string.
    # @param pString Full string.
    # @return String with name expression.
    def capture_expression(_pString)
      raise NotImplementedError
    end
  end # End class
end # module
