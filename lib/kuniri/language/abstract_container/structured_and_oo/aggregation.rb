module Languages

  # @abstract Aggregation is a container for handling aggregation among classes
  class Aggregation

    public

      # Verify if line has an aggregation
      # @param pLine Line with the potential class.
      # @return Return an object ClassData if it find a class in the line,
      #         otherwise return nil.
      def get_aggregation(pLine)
        raise NotImplementedError
      end

    protected

      # Detect if an aggregation exists
      # @param pLine Line to inspect.
      # @return Returns an row string, otherwise returns nil.
      def detect_aggregation(pLine)
        raise NotImplementedError
      end

  # class
  end

# module
end
