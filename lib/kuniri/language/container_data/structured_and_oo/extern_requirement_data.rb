require_relative 'basic_data'

module Languages

  # ExternRequirementData Handling extern requirements
  class ExternRequirementData < Languages::BasicData

    public

      attr_reader :library

      def initialize(pRequirement)
        return nil if pRequirement.nil? or !pRequirement.is_a? String
        @name = pRequirement
      end

      # Set library of extern requirement.
      # @param pLibrary Library inside the extern requirement.
      def setLibrary(pLibrary)
        if pLibrary.nil? or !pLibrary.is_a? String or pLibrary.empty?
          return nil 
        end

        @library = pLibrary
      end

  # Class
  end

# Module
end
