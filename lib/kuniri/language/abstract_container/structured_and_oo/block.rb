module Languages

  # @abstract Class responsible for handling block.
  class Block

    public
      # Verify if a line has an block. If it has block, firstly, the
      # function capture all lines.
      # @param pLine An line to be analysed for find block.
      # @return Return on filled object of BlockData if it find an
      #         block, otherwise it returns nil.
      def get_block(pLine)
        raise NotImplementedError
      end

    protected

      # Method with a regex to check if line has a block.
      # @param pLine String with potential block inside.
      # @return Partial string with detection, otherwise return nil.
      def detect_block(pLine)
        raise NotImplementedError
      end


      # Set the name of the block based on the name captured.
      # Note: If this method is executed, we suppose we already have a block
      # as a string.
      # @param pString Partial string to be handled.
      # @return String with block name in uppercase.
      def capture_block_name(pString)
        raise NotImplementedError
      end

      # Extract expression from the captured string.
      # @param pString Full string.
      # @return String with name expression.
      def capture_expression(pString)
        raise NotImplementedError
      end

  # End class
  end

# module
end
