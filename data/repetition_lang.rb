require_relative '../abstract_container/structured_and_oo/global_tokens'
require_relative '../abstract_container/structured_and_oo/repetition'
require_relative '../container_data/structured_and_oo/repetition_data'

module Languages

  module {LANG}

    # Class responsible for handling {LANG} repetition data structures.
    class Repetition{LANG} < Languages::Repetition

      public

        # Get {LANG} repetition structure.
        # @see Languages::Repetition
        def get_repetition(pLine)
          # YOUR CODE HERE
        end

      protected

        # Override
        def detect_repetition(pLine)
          # YOUR CODE HERE
        end

        # Override
        def repetition_type(pString)
          # YOUR CODE HERE
        end

        # Override
        def get_expression(pType, pString)
          # YOUR CODE HERE
        end

        # Override
        def remove_unnecessary_information(pString)
          # YOUR CODE HERE
        end

    # class
    end

  # Module
  end

# Module
end
