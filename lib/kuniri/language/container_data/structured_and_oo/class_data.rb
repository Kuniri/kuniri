require_relative 'basic_data'
require_relative 'attribute_data'
require_relative 'method_data'
require_relative 'constructor_data'

module Languages

  # Handling class information
  class ClassData < Languages::BasicData

    public

      attr_accessor :inheritances
      attr_reader :attributes
      attr_reader :methods
      attr_reader :constructors

      def initialize
        @inheritances = [] 
        @attributes = []
        @methods = []
        @constructors = []
        @visibility = "public"
      end

      def add_attribute(pAttribute)
        # Rememeber, attribute can be a list of AttributeData
        pAttribute.each do |attributeElement|
          return unless attributeElement.is_a?(Languages::AttributeData)
          @attributes.push(attributeElement)
        end
      end

      def add_method(pMethod)
        return unless pMethod.is_a?(Languages::MethodData)

        @methods.push(pMethod)
      end

      def add_constructor(pConstructor)
        return if not pConstructor.is_a?(Languages::ConstructorData)

        @constructors.push(pConstructor)
      end

# TODO: REMOVE IT!
      def get_methods
        @methods
      end

      def get_attributes
        @attributes
      end

      def get_constructors
        @constructors
      end

  # Class
  end

# Module
end

