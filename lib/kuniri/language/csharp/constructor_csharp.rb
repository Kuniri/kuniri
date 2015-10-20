require_relative '../abstract_container/structured_and_oo/constructor'
require_relative '../container_data/structured_and_oo/constructor_data'
require_relative 'function_behavior_csharp'

module Languages

  module Csharp

    # Handling Csharp constructor
    class ConstructorCsharp < Languages::Csharp::FunctionBehaviorCsharp

      public

        def get_constructor(pLine, type = 'public')
          result = get_function(pLine)
          return nil unless result
          access_regex = /public|private|protected|static/
          if pLine =~ /^\s*#{access_regex}\s+(\w+)\s*\((.*)\)\s*$/
            result.type = "CONSTRUCTOR"
          end

          return result
        end

    # Class
    end

  # Csharp
  end

# Language
end
