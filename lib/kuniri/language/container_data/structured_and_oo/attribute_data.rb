require_relative 'basic_data'

module Languages

  # Handling attributes data.
  class AttributeData < Languages::BasicData

    public

      # Basic initialization of attribute.
      # @param pAttribute_name Attribute name for basic initialization.
      def initialize (pAttribute_name)
        return nil if pAttribute_name.nil? or !pAttribute_name.is_a? String

        @name = pAttribute_name
        @visibility = "public"
      end

    private

      # Type of the attribute.
      @type

  # Class
  end

# Module
end
