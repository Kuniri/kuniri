require_relative 'function_abstract'

module Languages

  # Handle function data
  class FunctionData < Languages::FunctionAbstract

    public

      # Initialize function data based on name.
      # @param pFunctionName name string.
      def initialize(pFunctionName)
        super(pFunctionName)
        @type = GLOBAL_FUNCTION_DATA
      end

      # Copy elements from an object of FunctionAbstract to Method
      # @param functionAbstractToMethod Reference from FunctionAbstract
      def << (abstractToGlobalFunction)
        unless abstractToGlobalFunction.is_a?(Languages::FunctionAbstract)
          return nil
        end
        @name = abstractToGlobalFunction.name
        @parameters = abstractToGlobalFunction.parameters
        @conditionals = abstractToGlobalFunction.conditionals
        @repetitions = abstractToGlobalFunction.repetitions
        @visibility = abstractToGlobalFunction.visibility
        @comments = abstractToGlobalFunction.comments
        @type = GLOBAL_FUNCTION_DATA
      end

  # class
  end

# Module
end
