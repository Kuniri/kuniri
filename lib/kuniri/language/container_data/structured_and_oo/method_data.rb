require_relative 'function_abstract'

module Languages

  # Handling method informations
  class MethodData < Languages::FunctionAbstract

    public

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
        @conditionals = functionAbstractToMethod.conditionals
        @repetitions = functionAbstractToMethod.repetitions
        @visibility = functionAbstractToMethod.visibility
        @comments = functionAbstractToMethod.comments
        @type = METHOD_DATA
      end

  # Class
  end

# Module
end
