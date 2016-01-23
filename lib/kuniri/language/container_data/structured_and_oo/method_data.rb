require_relative 'function_abstract'

module Languages

  # Handling method informations
  class MethodData < Languages::FunctionAbstract

    public

      # Initialize Method object, based on name.
      # @param pMethodName Method name.
      def initialize(pMethodName)
        super(pMethodName)
        @type = METHOD_DATA
      end

  # Class
  end

# Module
end
