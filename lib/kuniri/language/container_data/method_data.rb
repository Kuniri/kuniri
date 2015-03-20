require_relative 'function_abstract'

module Languages

  # Handling method informations
  class MethodData < Languages::FunctionAbstract

    public

      attr_reader :parameters
      attr_reader :belongs_to_class

      def initialize(pMethod_name)
        super(pMethod_name)
      end

      def belongs_to(pClass)
        @belongs_to_class = pClass
      end

  # Class
  end

# Module
end
