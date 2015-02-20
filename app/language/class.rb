
module Languages

  # @abstract Class is an container for handling class
  class Class

    public

      # Get class from line.
      # @param pLine Line with the potential class
      # @return Return a class object, otherwise return nil.
      def get_class(pLine)
        raise NotImplementedError
      end

    protected

      def detect_class(pLine)
        raise NotImplementedError
      end

      def get_inharitance
        raise NotImplementedError
      end

  # Class
  end

# Languages
end
