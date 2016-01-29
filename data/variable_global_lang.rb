require_relative '../abstract_container/structured_and_oo/variable_global'
require_relative '../container_data/structured_and_oo/variable_global_data'

module Languages

  module {LANG}

    # VariableGlobal{LANG} Handling extern requirements.
    class VariableGlobal{LANG} < Languages::VariableGlobal

      public

        # Get {LANG} variable.
        # @see Languages::VariableGlobal
        def get_variable(pLine)
          # YOUR CODE HERE
        end

      protected

        # Override
        def detect_variable(pLine)
          # YOUR CODE HERE
        end

        # Override
        def remove_unnecessary_information(pLine)
          # YOUR CODE HERE
        end

        # Override
        def prepare_final_string(pString)
          # YOUR CODE HERE
        end

        # Override
        def handle_multiple_declaration_with_comma(pString)
          # YOUR CODE HERE
        end

        # Override
        def handle_multiple_declaration_with_equal(pString)
          # YOUR CODE HERE
        end

        # Override
        def handle_line_declaration(pString)
          # YOUR CODE HERE
        end


    # Class
    end

  # Module
  end

# Module
end
