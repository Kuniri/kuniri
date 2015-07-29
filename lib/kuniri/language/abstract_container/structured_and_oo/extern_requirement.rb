module Languages

  # ExternRequirement is responsible for handling external requirement.
  # An external requirement is the "#include" in C, "require" in Ruby,
  # "import" in Java, etc.
  class ExternRequirement

    public

      # Get requirement name.
      # @param pLine Line to be analysed.
      # @return Return the ExternRequirementData object, or nil.
      def get_requirement(pLine)
        raise NotImplementedError
      end

    protected

      # @param pLine Line to detect requirement.
      # @return Returns a string with row extern requirement, or nil if not
      #         detects anything.
      def detect_extern_requirement(pLine)
        raise NotImplementedError
      end

      # @param pLine Line with row string to be pruned.
      # @return Returns an string.
      def remove_unnecessary_information(pLine)
        raise NotImplementedError
      end

  # Class
  end

# Module
end
