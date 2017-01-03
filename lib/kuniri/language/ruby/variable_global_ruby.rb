require_relative '../abstract_container/structured_and_oo/variable_global'
require_relative 'variable_behaviour_ruby'

module Languages

  module Ruby

    # VariableGlobalRuby Handling extern requirements.
    class VariableGlobalRuby < Languages::VariableGlobal

      public

        def initialize
          super
          @detectRegex = /^\s*(?:@|@@|\$)(.*)|(\w+\s*=[^=].*)$/
          setup_variable_behaviour(@detectRegex)
        end

        def get_variable(pLine)
          varCandidates = @variableBehaviour.common_declaration(pLine, 'useless')
          return nil if varCandidates.empty?

          globalVariables = []

          varCandidates.each do |variable, value|
            next unless is_variable?(variable)
            variable = variable.delete('@')
            variable = variable.delete('$')
            var = create_variable_data(variable, value)
            globalVariables.push(var)
            varCandidates.delete(variable)
          end

          return nil if globalVariables.empty?
          return globalVariables
        end

      private

        def is_variable?(pVariable)
          return false if pVariable.strip.split(' ').size > 1
          return true
        end

        def create_variable_data(variable, value = '')
          globalVariable = VariableGlobalData.new(variable)
          globalVariable.value = value.strip unless value.empty?
          return globalVariable
        end

    # Class
    end
  # Module
  end
# Module
end
