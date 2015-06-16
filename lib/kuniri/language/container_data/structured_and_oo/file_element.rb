require_relative 'basic_data'
require_relative 'function_data'
require_relative 'variable_global_data'
require_relative 'extern_requirement_data'

module Languages
 
  class FileElement < Languages::BasicData

    public

      attr_reader :global_functions
      attr_reader :global_variables
      attr_reader :extern_requirements
      attr_reader :classes

      def initialize(pName)
        @global_functions = []
        @global_variables = []
        @extern_requirements = []
        @classes = []
        @name = pName
      end

      def add_global_function(pFunction)
        return if not pFunction.is_a?(Languages::FunctionData)

        @global_functions.push(pFunction)
      end

      def add_global_variable(pVariable)
        # Check all element and add it
        pVariable.each do |element|
          next if not element.is_a?(Languages::VariableGlobalData)
          @global_variables.push(element)
        end
      end

      def add_extern_requirement(pOutside)
        return if not pOutside.is_a?(Languages::ExternRequirementData)

        @extern_requirements.push(pOutside)
      end

      def add_class(pClass)
        return if not pClass.is_a?(Languages::Class)

        @classes.push(pClass)
      end

  # Class
  end

# Module
end
