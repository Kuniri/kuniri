require_relative '../abstract_container/structured_and_oo/attribute'
require_relative '../container_data/structured_and_oo/attribute_data'
require_relative '../../core/setting'

module Languages

  module {LANG}

    # Handling {LANG} attributes
    class Attribute{LANG} < Languages::Attribute

      public

        def initialize
          # YOUR CODE HERE
        end

        # Get {LANG} attribute.
        # @param pLine Verify if line has a {LANG} attribute.
        # @return Return AttributeData or nil.
        def get_attribute(pLine)
          # YOUR CODE HERE
        end

    protected

      # Override
      def detect_attribute(pLine)
        # YOUR CODE HERE
      end

      # Override
      def remove_unnecessary_information(pString)
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

    #Class
    end

  # {LANG}
  end
#Language
end
