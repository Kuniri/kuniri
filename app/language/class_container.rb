module Languages

  class ClassContainer
    attr_accessor :className
    attr_reader :methods
    attr_reader :attributes

    def initialize
      @methods = Array.new
      @attributes = Array.new
    end

    def add_method(methodName)
      methods.push(methodName)
    end

    def add_attribute(attributeName)
      attributes.push(attributeName)
    end
  end
end
