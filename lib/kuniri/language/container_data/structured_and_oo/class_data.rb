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
        @comments = ""
      end

      # Add attribute to class data, notice the possibility of call this
      # method more than one time.
      # @param pAttribute Attribute to be added inside class. This attribute
      #         is a list of AttributeData.
      def add_attribute(pAttribute)
        pAttribute.each do |attributeElement|
          return unless attributeElement.is_a?(Languages::AttributeData)
          @attributes.push(attributeElement)
        end
      end

      # Add method inside ClassData. Remember the possibility of have zero or
      # any method inside a class.
      # @param pMethod It is an object of FunctionData with the method
      #         informations.
      def add_method(pMethod)
        return unless pMethod.is_a?(Languages::MethodData)

        @methods.push(pMethod)
      end

      # Add constructor inside class.
      # @param pConstructor Object of FunctionData to be added at class.
      def add_constructor(pConstructor)
        return unless pConstructor.is_a?(Languages::FunctionData)

        @constructors.push(pConstructor)
      end

  # Class
  end

# Module
end

