require_relative 'basic_data'

module Languages

  # Handling method informations
  class MethodData < Languages::BasicData

    public

      attr_reader :parameters

      def initialize(method_name)
        @name = method_name
        @parameters = []
      end

      def add_parameters(value)
        @parameters.push(value)
      end

  # Class
  end

# Module
end
