class Class1

    attr_accessor :value

    def initialize(value)
        @value = value
    end

    def print_value()
        puts @value
    end

end

class Class2

  def initialize()
    @value = 10
  end

end

class Class3

    attr_accessor :class1, :class2

    @class1 = Class1.new(10)
    @class2 = Class2      .       new 10

    def initialize()
    end

    def print_value
        puts @class.print_value()
    end

end
