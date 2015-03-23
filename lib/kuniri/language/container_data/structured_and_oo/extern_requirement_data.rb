require_relative 'basic_data'

module Languages

  # @class ExternRequirementData Handling extern requirements
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
