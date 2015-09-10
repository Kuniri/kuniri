require_relative 'basic_data'
require_relative 'function_data'
require_relative 'variable_global_data'
require_relative 'extern_requirement_data'
require_relative 'module_namespace_data'
require_relative 'class_data'

module Languages

  # FileElementData is the upper element related with container data, this class
  # refers to file.
  class FileElementData < Languages::BasicData

    public

      attr_reader :global_functions
      attr_reader :global_variables
      attr_reader :extern_requirements
      attr_reader :classes
      attr_reader :modules

      def initialize(pName)
        return nil if pName.nil? or !pName.is_a? String

        @global_functions = []
        @global_variables = []
        @extern_requirements = []
        @classes = []
        @modules = []
        @name = pName
        @comments = ""
      end

      # Add global function to the file.
      # @param pFunction An object of FunctionData to be added at the file.
      def add_global_function(pFunction)
        return nil if not pFunction.is_a?(Languages::FunctionData)

        @global_functions.push(pFunction)
      end

      # Add global variable inside file.
      # @param pVariable A single VariableGlobalData object or list to be added.
      def add_global_variable(*pVariable)
        pVariable.flatten.each do |element|
          next unless element.is_a?(Languages::VariableGlobalData)
          @global_variables.push(element)
        end
      end

      # Add extern requirement inside file.
      # @param pOutside Add an object of ExternRequirementData.
      def add_extern_requirement(pOutside)
        return nil unless pOutside.is_a?(Languages::ExternRequirementData)

        @extern_requirements.push(pOutside)
      end

      # Add a class inside file.
      # @param pClass Add an object of ClassData.
      def add_class(pClass)
        return nil unless pClass.is_a?(Languages::ClassData)

        @classes.push(pClass)
      end

      # Add a module inside file.
      # @param pModule Add an object of ModuleNamespaceData
      def add_modules(pModule)
        return nil unless pModule.is_a?(Languages::ModuleNamespaceData)

        @modules.push(pModule)
      end

  # Class
  end

# Module
end
