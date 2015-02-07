require_relative 'basic_data'

module Languages

  # 
  class MethodData < Languages::BasicData
    public
      def initialize(method_name)
        name = method_name
        @parameters = []
      end

      def add_parameters(value)
        @parameters.push(value)
      end

    private
      @parameters
  end
end
