class Test1

    attr_accessor :value

    def initialize(value)
        @value = value
    end

    def print_value()
        puts @value
    end

end

class Test2

  def initialize()
    @value = 10
  end

end

class Test2

    attr_accessor :test1, :test2

    def initialize()
    end

    def print_value
        @test1 = Test1.new(10)
        @test2 = Test2      .       new 10
        puts @test.print_value()
    end

end
