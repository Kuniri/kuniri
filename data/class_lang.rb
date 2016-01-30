require_relative '../abstract_container/structured_and_oo/class'
require_relative '../container_data/structured_and_oo/class_data'
require_relative '../../core/setting'

module Languages

  module {LANG}

    # Class responsible for handling {LANG} classes.
    class Class{LANG} < Languages::Class

      public

        def initialize
          # YOUR CODE HERE
        end

        # Get {LANG} class.
        # @see Languages::Class
        def get_class(pLine)
          # YOUR CODE HERE
        end

      protected

        # Override
        def detect_class(pLine)
          # YOUR CODE HERE
        end

        # Override
        def get_inheritance(pString)
          # YOUR CODE HERE
        end

        # Override
        def remove_unnecessary_information(pString)
          # YOUR CODE HERE
        end

        def prepare_final_string(pString)
          # YOUR CODE HERE
        end

      private
        # YOU CAN HAVE CODE HERE...

    # class
    end

  # {LANG}
  end

# Languages
end
