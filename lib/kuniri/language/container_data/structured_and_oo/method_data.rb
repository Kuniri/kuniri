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

      # Copy elements from an object of FunctionAbstract to Method
      # @param functionAbstractToMethod Reference from FunctionAbstract
      def << (functionAbstractToMethod)
        unless functionAbstractToMethod.is_a?(Languages::FunctionAbstract)
          return nil
        end
        @name = functionAbstractToMethod.name
        @parameters = functionAbstractToMethod.parameters
        @managerCondAndLoop = functionAbstractToMethod.managerCondAndLoop
        @visibility = functionAbstractToMethod.visibility
        @comments = functionAbstractToMethod.comments
        @type = METHOD_DATA
      end

  # Class
  end

# Module
end
