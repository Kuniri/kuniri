require 'set'

class Class1 < Array

    attr_accessor :value

    def initialize(value)
        @value = value
    end

    def print_value()
        puts @value
    end

end

class Class2 < Class1

  def initialize()
    @value = 10
  end

end

class Class3 < Class2

  def initialize(value)
    @value = value
  end

end

class Class4 < Class3

  def initialize(value)
    @value = value
  end

end

class Class5             <             Set    

    attr_accessor :class1, :class2, :class3, :class4, :class5, :class6

    @class1 = Class1.new(10)
    @class2 = Class2      .       new

    def initialize()
      @class3 = Class3.new(20)
      @class4 = Array.new
      @class5 = Set.new
      @class6 = Class1.new
    end

    def print_value
        puts @class.print_value()
    end

end