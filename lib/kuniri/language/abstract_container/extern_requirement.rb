module Languages

  # @class ExternRequirement Responsible for handling extern requirement.
  # 
  # An external requirement is the "#include" in C, "require" in Ruby,
  # "import" in Java, etc.
  class ExternRequirement

    public

      # @param pLine Line to analyse.
      # @return Return the requirement name.
      # Get requirement name
      def get_requirement(pLine)
        raise NotImplementedError
      end

    protected

      # @param pLine Line to detect requirement.
      # @return 
      def detect_extern_requirement(pLine)
        raise NotImplementedError
      end

      # @param pLine
      # @return
      def remove_unnecessary_information(pLine)
        raise NotImplementedError
      end

  # Class
  end

# Module
end
