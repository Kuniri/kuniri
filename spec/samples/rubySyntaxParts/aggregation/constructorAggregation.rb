class Foo
    
    attr_accessor :value

    def initialize()
        @value = 10
    end

    def print_value()
        puts @value
    end

end

class Blah

  def initialize()
    @value = 20
  end

end

class Bar

    attr_accessor :foo1, :foo2

    def initialize()
        @foo1 = Foo.new
        @foo2 = Blah      .new
    end

    def print_value
        puts @foo.print_value()
    end

end
