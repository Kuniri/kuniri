require_relative 'basic_data'

module Languages

  # Handling attributes data.
  class AttributeData < Languages::BasicData

    public

      attr_accessor :value
      attr_accessor :type

      # Basic initialization of attribute.
      # @param pAttribute_name Attribute name for basic initialization.
      def initialize (pAttributeName)
        return nil if pAttributeName.nil? or !pAttributeName.is_a? String

        @name = pAttributeName
        @visibility = "public"
      end

    private

      # Type of the attribute.
      @type

  # Class
  end

# Module
end
