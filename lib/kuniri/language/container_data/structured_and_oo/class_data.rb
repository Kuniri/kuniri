require_relative 'basic_data'
require_relative 'attribute_data'
require_relative 'method_data'
require_relative 'constructor_data'

module Languages

  # Handling class information
  class ClassData < Languages::BasicData

    public

      attr_accessor :inheritances

      def initialize
        @inheritances = [] 
        @attributes = []
        @methods = []
        @constructors = []
        @visibility = "public"
      end

      def add_attribute(pAttribute)
        return if not pAttribute.is_a?(Languages::AttributeData)

        @attributes.push(pAttribute)
      end

      def add_method(pMethod)
        return if not pMethod.is_a?(Languages::MethodData)

        @methods.push(pMethod)
      end

      def add_constructor(pConstructor)
        return if not pConstructor.is_a?(Languages::ConstructorData)

        @constructors.push(pConstructor)
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

# REMOVE IT SOON! JUST DEBUG
#      def dumpClassData
#        puts "-" * 40
#        puts "> METHOD"
#        @methods.each do |i|
#          puts "#{i.visibility} -> #{i.name}"
#        end
#        puts "-"  * 40
#        puts "> INITIALIZE"
#        @constructors.each do |i|
#          puts "#{i.visibility} -> #{i.name}"
#        end
#        puts "*" * 40
#        puts "> ATTRIBUTE"
#        @attributes.each do |i|
#          puts "#{i.visibility} -> #{i.name}"
#        end
#        puts "_" * 40
#        puts "> COUNT:"
#        puts "Methods: #{@methods.size()}"
#        puts "Attributes: #{@attributes.size()}"
#        puts "constructors: #{@constructors.size()}"
#      end

    private

      @attributes
      @methods
      @constructors

  # Class
  end

# Module
end

