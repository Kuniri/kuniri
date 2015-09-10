require_relative 'function_abstract'

module Languages

  # Handling constructor information.
  class ConstructorData < Languages::FunctionAbstract

    public

      def initialize(pConstructorName)
      	if pConstructorName.nil? or !pConstructorName.is_a? String
          raise ArgumentError
        end
        super(pConstructorName)
      end

  # Class
  end

# Module
end
