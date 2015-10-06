require_relative '../abstract_container/structured_and_oo/constructor'
require_relative '../container_data/structured_and_oo/constructor_data'
require_relative 'function_behavior_java'

module Languages

  module Java

    # Handling Java constructor
    class ConstructorJava < Languages::Java::FunctionBehaviorJava

      public

        def get_constructor(pLine, type = 'public')
          result = get_function(pLine)
          return nil unless result

          if result.name =~ /initialize/
            result.type = "CONSTRUCTOR"
          else
            return nil
          end

          return result
        end

    # Class
    end

  # Java
  end

# Language
end
