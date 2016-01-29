require_relative '../container_data/structured_and_oo/method_data'
require_relative 'function_behavior_{lang}'

module Languages

  module {LANG}

    # Handling {LANG} method
    class Method{LANG} < Languages::{LANG}::FunctionBehavior{LANG}

      public

        # Get {LANG} method.
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
