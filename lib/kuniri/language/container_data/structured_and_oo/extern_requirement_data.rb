require_relative 'basic_data'

module Languages

  # ExternRequirementData Handling extern requirements
  class ExternRequirementData < Languages::BasicData

    public

      attr_reader :library

      def initialize(pRequirement)
        return if pRequirement.nil? or !pRequirement.is_a? String

        @name = pRequirement
      end

      # Set library of extern requirement.
      # @param pLibrary Library inside the extern requirement.
      def setLibrary(pLibrary)
        return if pLibrary.nil? or !pLibrary.is_a? String or pLibrary.empty?

        @library = pLibrary
      end

  # Class
  end

# Module
end
