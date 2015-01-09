
module Languages

  class MethodContainer
    attr_reader :name
    attr_reader :parameters
    attr_reader :returnType
    attr_reader :visibility

    def add_parameter(value)
      @parameters.push(value)
    end
  end

end
