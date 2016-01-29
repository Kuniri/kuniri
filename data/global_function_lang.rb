require_relative '../container_data/structured_and_oo/function_data'
require_relative 'function_behavior_{lang}'

module Languages

  module {LANG}

    # Handling {LANG} global function
    class GlobalFunction{LANG} < Languages::{LANG}::FunctionBehavior{LANG}

      public

        # Get {LANG} global function.
        # @see FunctionBehavior{LANG}
        def get_method(pLine, type = 'public')
          # YOUR CODE HERE
        end

    # Class
    end

  # {LANG}
  end

# Language
end
