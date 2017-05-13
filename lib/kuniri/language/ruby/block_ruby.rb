#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

require_relative '../abstract_container/structured_and_oo/block'
require_relative '../container_data/structured_and_oo/block_data'
require_relative '../abstract_container/structured_and_oo/global_tokens'

module Languages

  module Ruby

    # Ruby Handling Ruby block
    class BlockRuby < Languages::Block
      # Get ruby block.
      # @param pLine Verify if line has a ruby block.
      # @return Return BlockData or nil.
      def get_block(pLine)
        result = detect_block(pLine)
        return nil unless result

        blockData = Languages::BlockData.new
        if @isItALambda
          blockData.type = Languages::LAMBDA_LABEL
          blockData.expression = Languages::LAMBDA_LABEL
        else
          blockData.type = Languages::BLOCK_LABEL
          blockData.expression = capture_block_name(result)
        end
        return blockData
      end

      protected

      # Override
      def detect_block(pLine)
        return check_for_block(pLine) || check_for_lambda(pLine)
      end

      def among_quotes?(pLine)
        quotes_regex = /["'].*["']/
        return true if quotes_regex =~ pLine
        return false
      end

      # Override
      def capture_block_name(pString)
        regexExp = /\.(\s*\w+)\s+do/
        partialString = pString[regexExp, 1]
        partialString.strip!
        partialString.upcase!
        return partialString
      end

      def capture_expression(_pString)
        return 'NO EXPRESSION INSIDE BLOCK'
      end

      private

      @isItALambda = false

      def check_for_block(pLine)
        regexExp = /(\w\w*\s*\.\s*)+([a-zA-Z_]\w*)\s+do\s+\|([^\|]+)\|/
        if regexExp =~ pLine
          @isItALambda = false
          return pLine[regexExp, 0] unless among_quotes?pLine
        end
        return nil
      end

      # TODO
      def check_for_lambda(pLine)
        regexExp = /(\w+\s+|\s*)lambda(:?\s+do\s*|\s*\{\s*)/
        if regexExp =~ pLine
          @isItALambda = true
          return pLine[regexExp, 0] unless among_quotes?pLine
        end
        return nil
      end

    end # Class
  end # Ruby
end # Language
