require_relative '../abstract_container/structured_and_oo/variable_global'
require_relative 'variable_behaviour_ruby'

module Languages

  module Ruby

    # VariableGlobalRuby Handling extern requirements.
    class VariableGlobalRuby < Languages::VariableGlobal

      public

        def initialize
          detectRegex = /^\s*(?:@|@@|\$)(.*)|(\w+\s+=.*)$/
          # XXX: Kludge, REMOVE 'VariableGlobal' and make it in the correct way
          super(Languages::Ruby::VariableBehaviourRuby.new('VariableGlobal'), detectRegex)
        end

    # Class
    end

  # Module
  end

# Module
end
