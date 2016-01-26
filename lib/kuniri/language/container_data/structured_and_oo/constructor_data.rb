require_relative 'function_abstract'

module Languages

  # Handling constructor information.
  class ConstructorData < Languages::FunctionAbstract

    public

      # Constructor based on name.
      def initialize(pConstructorName)
        super(pConstructorName)
        @type = CONSTRUCTOR_DATA
      end

  # Class
  end

# Module
end
