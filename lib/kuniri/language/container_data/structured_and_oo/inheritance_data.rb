require_relative 'basic_data'

module Languages

  # Handling inheritance data.
  class InheritanceData < Languages::BasicData

    public

      attr_accessor :isInProject

      # Basic initialization of inheritance.
      # @param pInheritance_name Inheritance name for basic initialization.
      def initialize (pInheritanceName)
        return nil if pInheritanceName.nil? or !pInheritanceName.is_a? String

        @name = pInheritanceName
        @isInProject = false
      end

  # Class
  end

# Module
end
