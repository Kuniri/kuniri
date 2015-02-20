require_relative 'basic_data'

module Languages
  # Class responsable for handling attributes.
  class AttributeData < Languages::BasicData

    public

      def initialize (attribute_name)
        @name = attribute_name
        @visibility = "public"
      end

    private

      @type

  end
end
