require_relative 'function_abstract'

module Languages

  # Handling method informations
  class MethodData < Languages::FunctionAbstract

    public

      attr_reader :parameters

      def initialize(pMethod_name)
      	return nil if pMethod_name.nil? or !pMethod_name.is_a? String

        super(pMethod_name)
      end

  # Class
  end

# Module
end
