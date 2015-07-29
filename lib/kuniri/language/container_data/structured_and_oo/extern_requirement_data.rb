require_relative 'basic_data'

module Languages

  # ExternRequirementData Handling extern requirements
  class ExternRequirementData < Languages::BasicData

    public

      attr_reader :path

      def initialize(pRequirement)
        @name = pRequirement
      end

      # Set path of extern requirement.
      # @param pPath Path inside the extern requirement.
      def setPath(pPath)
        @path = pPath
      end

  # Class
  end

# Module
end
