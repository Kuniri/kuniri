module Languages

  class ExternRequirementData < Languages::BasicData

    public

      attr_reader :path

      def initialize(pRequirement)
        @name = pRequirement
      end

      def setPath(pPath)
        @path = pPath
      end

  # Class
  end

# Module
end
