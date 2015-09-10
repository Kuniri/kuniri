require_relative 'basic_data'

module Languages

  # ExternRequirementData Handling extern requirements
  class ExternRequirementData < Languages::BasicData

    public

      attr_reader :path

      def initialize(pRequirement)
        if pRequirement.nil? or !pRequirement.is_a? String
          raise ArgumentError
        end
        @name = pRequirement
      end

      # Set path of extern requirement.
      # @param pPath Path inside the extern requirement.
      def setPath(pPath)
        if pPath.nil? or !pPath.is_a? String or !File.exist?(pPath)
          raise ArgumentError
        end
        @path = pPath
      end

  # Class
  end

# Module
end
