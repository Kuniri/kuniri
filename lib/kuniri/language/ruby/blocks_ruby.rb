require_relative '../abstract_container/structured_and_oo/block'
require_relative '../container_data/structured_and_oo/blocks_data'

module Languages

  module Ruby

    # Ruby Handling Ruby blocks
    class BlocksRuby < Languages::Block

      public

        def initialize
        end

        # Get ruby blocks.
        # @param pLine Verify if line has a ruby blocks.
        # @return Return BlockData or nil.
        def get_blocks(pLine)
          result = detect_blocks(pLine)
          return nil unless result

          blockData = Languages::BlocksData.new(result)
          blockData.name = capture_block_name(result)
          return blockData
        end

    protected

      # Override
      def detect_blocks(pLine)
        regexExp = /\.(\s*\w+)\s+do\s+\|\s*(.*)\|\s*/
        return pLine[regexExp, 0] if regexExp =~ pLine
      end

      #Override
      def capture_block_name(pString)
        regexExp = /\.(\s*\w+)\s+do/
        partialString = pString[regexExp, 1]
        partialString.strip!
        partialString.upcase!
        return partialString
      end

    #Class
    end

  # Ruby
  end

#Language
end
