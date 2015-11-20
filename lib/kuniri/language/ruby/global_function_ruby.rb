require_relative '../abstract_container/structured_and_oo/global_function'
require_relative '../container_data/structured_and_oo/function_data'
require_relative 'function_behavior_ruby'

module Languages

  module Ruby

    # Handling ruby global function
    class GlobalFunctionRuby < Languages::Ruby::FunctionBehaviorRuby

      public

        # Get Ruby global function.
        # @see FunctionBehaviorRuby
        def get_method(pLine, type = 'public')
          result = get_function(pLine)
          return nil unless result

          functionData = FunctionData.new(result.name)
          functionData << result

          return functionData
        end

    # Class
    end

  # Ruby
  end

# Language
end
