require_relative '../abstract_container/structured_and_oo/constructor'
require_relative '../container_data/structured_and_oo/constructor_data'
require_relative 'function_behavior_cplusplus'

module Languages

  module Cplusplus

    # Handling Cplusplus constructor
    class ConstructorCplusplus < Languages::Cplusplus::FunctionBehaviorCplusplus

      public

        def get_constructor(pLine, type = 'globalFunction')
          class_name = get_class(pLine)
          result = get_function(pLine)
          return nil unless result

          if(class_name == result.name)
            result.type = "CONSTRUCTOR"
          end

          return result

        end

      private

        def get_class(pLine)
          regexExpression = /\s*(\w+)\s*(::)\s*(\w+)\s*\(.*\)/
          return nil unless pLine =~ regexExpression
          return $1
        end

    # Class
    end

  # Cplusplus
  end

# Language
end
