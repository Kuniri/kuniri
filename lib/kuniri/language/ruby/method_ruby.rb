require_relative '../container_data/structured_and_oo/method_data'
require_relative 'function_behavior_ruby'

module Languages

  module Ruby

    # Handling ruby method
    class MethodRuby < Languages::Ruby::FunctionBehaviorRuby

      public

        # Get Ruby method.
        # @see FunctionBehaviorRuby
        def get_method(pLine, type = 'public')
          result = get_function(pLine)
          return nil unless result

          methodData = MethodData.new(result.name)
          methodData << result

          return methodData
        end

    # Class
    end
  # Ruby
  end
# Language
end
