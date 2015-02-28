require_relative 'basic_data'

module Languages

  # Handling constructor information.
  class ConstructorData < Languages::BasicData

    public

      def initialize(pName)
        @name = pName
        @attributes = []
      end

      def add_attribute(pAttribute)
        @attributes.push(pAttribute)
      end

      def get_attributes
        return @attributes
      end

    private

      @attributes

  # Class
  end

# Module
end
