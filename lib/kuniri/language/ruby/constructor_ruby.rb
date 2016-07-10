require_relative '../container_data/structured_and_oo/constructor_data'
require_relative 'function_behavior_ruby'

module Languages

  module Ruby

    # Handling ruby constructor
    class ConstructorRuby < Languages::Ruby::FunctionBehaviorRuby

      public

        # Get Ruby constructor.
        # @see FunctionBehaviorRuby
        def get_constructor(pLine, type = 'public')
          result = get_function(pLine)
          return nil unless result
          return nil unless result.name =~ /initialize/

          constructorData = ConstructorData.new(result.name)
          constructorData << result

          return constructorData
        end
    # Class
    end
  # Ruby
  end
# Language
end
