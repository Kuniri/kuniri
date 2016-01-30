require_relative '../abstract_container/structured_and_oo/aggregation'
require_relative '../../core/setting'
require_relative '../container_data/structured_and_oo/aggregation_data'

module Languages

  module {LANG}

    # {LANG} handling aggregation
    class Aggregation{LANG} < Languages::Aggregation

      public

        # @param pLine Verify if line has a {LANG} aggregation.
        # @return Return string or nil.
        def get_aggregation(pLine)
          # YOUR CODE HERE
        end

    protected

      # Override
      def detect_aggregation(pLine)
        # YOUR CODE HERE
      end

    #Class
    end

  # {LANG}
  end
#Language
end
