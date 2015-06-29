require_relative 'basic_data'
require_relative 'function_data'
require_relative 'variable_global_data'
require_relative 'extern_requirement_data'
require_relative 'module_namespace_data'
require_relative 'class_data'

module Languages
 
  class FileElement < Languages::BasicData

    public

      attr_reader :global_functions
      attr_reader :global_variables
      attr_reader :extern_requirements
      attr_reader :classes
      attr_reader :modules

      def initialize(pName)
        @global_functions = []
        @global_variables = []
        @extern_requirements = []
        @classes = []
        @modules = []
        @name = pName
      end

      def add_global_function(pFunction)
        return if not pFunction.is_a?(Languages::FunctionData)

        @global_functions.push(pFunction)
      end

      def add_global_variable(pVariable)
        # Check all element and add it
        pVariable.each do |element|
          next unless element.is_a?(Languages::VariableGlobalData)
          @global_variables.push(element)
        end
      end

      def add_extern_requirement(pOutside)
        return unless pOutside.is_a?(Languages::ExternRequirementData)

        @extern_requirements.push(pOutside)
      end

      def add_class(pClass)
        return unless pClass.is_a?(Languages::ClassData)

        @classes.push(pClass)
      end

      def add_modules(pModule)
        return unless pModule.is_a?(Languages::ModuleNamespaceData)

        @modules.push(pModule)
      end

  # Class
  end

# Module
end
