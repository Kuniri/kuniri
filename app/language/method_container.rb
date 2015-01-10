
module Languages

  class MethodContainer
    attr_accessor :name
    attr_reader :parameters
    attr_accessor :returnType
    attr_accessor :visibility

    def add_parameter(value)
      @parameters.push(value)
    end
  end

end
