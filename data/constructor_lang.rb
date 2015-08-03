require_relative '../abstract_container/structured_and_oo/constructor'
require_relative '../container_data/structured_and_oo/constructor_data'
require_relative 'function_behavior_{lang}'

module Languages

  module {LANG}

    # Handling {LANG} constructor
    class ConstructorRuby < Languages::{LANG}::FunctionBehavior{LANG}

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

  # {LANG}
  end

# Language
end
