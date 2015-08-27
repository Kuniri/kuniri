require_relative '../abstract_container/structured_and_oo/end_block'

module Languages

  module Ruby

    # Class responsible for handling Ruby end of block.
    class EndBlockRuby < Languages::EndBlock

      public

        # Verify Ruby end of block.
        # @see EndBlock
        def has_end_of_block?(pLine)
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
