require_relative '../abstract_container/structured_and_oo/constructor'
require_relative '../container_data/structured_and_oo/constructor_data'
require_relative 'function_behavior_cplusplus'

module Languages

  module Cplusplus

    # Handling Cplusplus constructor
    class ConstructorCplusplus < Languages::Cplusplus::FunctionBehaviorCplusplus

      public

        def get_constructor(pLine, type = 'public')
          result = get_function(pLine)
          return nil unless result

          if result.name =~ /(\w*)::\1\(/
            result.name = $1
            result.type = "CONSTRUCTOR"
          else
            return nil
          end

          return result
        end

    # Class
    end

  # Cplusplus
  end

# Language
end
