require_relative 'function_abstract'

module Languages

  # Handling constructor information.
  class ConstructorData < Languages::FunctionAbstract

    public

      def initialize(pConstructorName)
      	return nil if pConstructorName.nil? or !pConstructorName.is_a? String

        super(pConstructorName)
      end

  # Class
  end

# Module
end
