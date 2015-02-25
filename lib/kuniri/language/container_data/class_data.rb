require_relative 'basic_data'
require_relative 'attribute_data'
require_relative 'method_data'
require_relative 'constructor_data'

module Languages

  # Handling class information
  class ClassData < BasicData

    public

      def initialize
        @attributes = []
        @methods = []
        @constructors = []
      end

      def add_attribute(attribute)
        return if not attribute.is_a?(Languages::AttributeData)

        @attributes.push(attribute)
      end

      def add_method(method)
        return if not method.is_a?(Languages::MethodData)

        @methods.push(method)
      end

      def add_constructor(constructor)
        return if not constructor.is_a?(Languages::ConstructorData)

        @constructors.push(constructor)
      end

      def get_methods
        @methods
      end

      def get_attributes
        @attributes
      end

      def get_constructors
        @constructors
      end

      def dumpClassData
        puts "-" * 40
        puts "> METHOD"
        @methods.each do |i|
          puts "#{i.visibility} -> #{i.name}"
        end
        puts "*" * 40
        puts "> ATTRIBUTE"
        @attributes.each do |i|
          puts "#{i.visibility} -> #{i.name}"
        end
        puts "_" * 40
        puts "> COUNT:"
        puts "Methods: #{@methods.size()}"
        puts "Attributes: #{@attributes.size()}"
        puts "constructors: #{@constructors.size()}"
      end

    private

      @attributes
      @methods
      @constructors

  # Class
  end

# Module
end

