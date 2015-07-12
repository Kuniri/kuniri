module Languages

  # Class responsible for handling end block of each language.
  class EndBlock

    public

      # Verify if the line has an end of line token.
      # @param pLine Line to inspect.
      # @return Return true if find an end block, otherwise return false.
      def has_end_of_block?(pLine)
        raise NotImplementedError
      end

    protected

      # Keeps some operation for find line.
      def detect_end(pLine)
        raise NotImplementedError
      end

  # End block
  end

# End module
end
