require_relative 'function'

module Languages

  # Handling method informations
  class MethodData < Languages::Function

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
