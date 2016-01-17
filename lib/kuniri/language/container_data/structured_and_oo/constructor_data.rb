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

      # Copy elements from an object of FunctionAbstract to Method
      # @param functionAbstractToMethod Reference from FunctionAbstract
      def << (functionAbstractToConstructor)
        unless functionAbstractToConstructor.is_a?(Languages::FunctionAbstract)
          return nil
        end
        @name = functionAbstractToConstructor.name
        @parameters = functionAbstractToConstructor.parameters
        @managerCondAndLoop = functionAbstractToConstructor.managerCondAndLoop
        @visibility = functionAbstractToConstructor.visibility
        @comments = functionAbstractToConstructor.comments
        @type = CONSTRUCTOR_DATA
      end


  # Class
  end

# Module
end
