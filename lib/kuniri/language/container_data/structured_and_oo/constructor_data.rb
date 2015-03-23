require_relative 'function_abstract'

module Languages

  # Handling constructor information.
  class ConstructorData < Languages::FunctionAbstract

    public

      attr_reader :belong_to_class

      def initialize(pConstructorName)
        super(pConstructorName)
      end

      def belongs_to(pClass)
        @belong_to_class = pClass
      end

  # Class
  end

# Module
end
