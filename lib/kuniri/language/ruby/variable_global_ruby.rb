require_relative '../abstract_container/structured_and_oo/variable_global'
require_relative 'variable_behaviour_ruby'

module Languages

  module Ruby

    # VariableGlobalRuby Handling extern requirements.
    class VariableGlobalRuby < Languages::VariableGlobal

      public

        def initialize
          super
          detectRegex = /^\s*(?:@|@@|\$)(.*)|(\w+\s+=.*)$/

          variableGlobal = @whoAmI.capitalize.concat('Global')
          ref = Languages::Ruby::VariableBehaviourRuby.new(variableGlobal)
          setup_attribute(ref, detectRegex)
        end

    # Class
    end

  # Module
  end

# Module
end
