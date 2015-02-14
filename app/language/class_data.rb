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
        if not attribute.is_a?(Languages::AttributeData)
          return
        end

        @attributes.push(attribute)
        return
      end

      def add_method(method)
        if not method.is_a?(Languages::MethodData)
          return
        end

        @methods.push(method)
        return
      end

      def add_constructor(constructor)
        if not constructor.is_a?(Languages::ConstructorData)
          return
        end

        @constructors.push(constructor)
        return
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

  end
end

