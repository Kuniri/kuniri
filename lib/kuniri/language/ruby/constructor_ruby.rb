require_relative '../abstract_container/structured_and_oo/constructor'
require_relative '../container_data/structured_and_oo/constructor_data'
require_relative 'function_behavior_ruby'

module Languages

  module Ruby

    # Handling ruby constructor
    class ConstructorRuby < Languages::Ruby::FunctionBehaviorRuby

      public

        def get_constructor(pLine, type = 'globalFunction')
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

  # Ruby
  end

# Language
end
