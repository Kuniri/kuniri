require_relative 'basic_data'
require_relative 'function_data'
require_relative 'global_variable_data'
require_relative 'outside_requirement'

module Languages
 
  class GlobalData < Languages::BasicData

      attr_reader :global_function
      attr_reader :glabal_variable
      attr_reader :outside_requirement

      def initialize
        @global_function = []
        @global_variable = []
        @outside_requirement = []
        @visibility = "global"
      end

      def add_global_function(pFunction)
        return if not pFunction.is_a?(Languages::FunctionData)

        @global_function.push(pFunction)
      end

      def add_global_variable(pVariable)
        return if not pVariable.is_a?(Languages::GlobalVariableData)

        @global_variable.push(pVariable)
      end

      def add_outside_requirement(pOutside)
        return if not pOutside.is_a?(Languages::OutsideRequirement)

        @outside_requirement.push(pOutside)
      end

  # Class
  end

# Module
end
