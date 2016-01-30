require_relative '../abstract_container/structured_and_oo/function_behavior'
require_relative '../../core/setting'
require_relative '../container_data/structured_and_oo/function_data'

module Languages

  module {LANG}

    # Handling Ruby method
    class FunctionBehavior{LANG} < Languages::FunctionBehavior

      public

        def initialize
          # YOUR CODE HERE
        end

        # Get {LANG} function.
        def get_function(pLine, type = 'globalFunction')
          # YOUR CODE HERE
        end

      protected

        # Override
        def detect_function(pLine)
          # YOUR CODE HERE
        end

        # Override
        def handling_default_parameter(pLine)
          # YOUR CODE HERE
        end

        # Override
        def remove_unnecessary_information(pLine)
          # YOUR CODE HERE
        end

        # Override
        def handling_parameter(pLine)
          # YOUR CODE HERE
        end

      private

        # Override
        def get_parameters(pLine, pRegex)
          # YOUR CODE HERE
        end

        # Override
        def split_string_by_comma(pString)
          # YOUR CODE HERE
        end

    # Class
    end

  # {Lang}
  end

# Language
end
