require_relative '../container_data/structured_and_oo/constructor_data'
require_relative 'function_behavior_{lang}'

module Languages

  module {LANG}

    # Handling {LANG} constructor
    class Constructor{LANG} < Languages::{LANG}::FunctionBehavior{LANG}

      public

        # Get {LANG} constructor.
        # @see FunctionBehaviorRuby
        def get_constructor(pLine, type = 'public')
          # YOUR CODE HERE
        end

    # Class
    end

  # {LANG}
  end

# Language
end
