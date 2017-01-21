#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

require_relative '../abstract_container/structured_and_oo/aggregation'
require_relative '../../core/setting'
require_relative '../container_data/structured_and_oo/aggregation_data'

module Languages

  module Ruby

    # Ruby Handling Ruby aggregation
    class AggregationRuby < Languages::Aggregation

      public

        # @param pLine Verify if line has a ruby aggregation.
        # @return Return string or nil.
        def get_aggregation(pLine)
          result = detect_aggregation(pLine)
          return nil unless result
          return Languages::AggregationData.new(result)
        end

    protected

      # Override
      def detect_aggregation(pLine)
        regexExp = /(\w*)\s*\.\s*new[\n|\s|\(]+/
        return nil unless pLine =~ regexExp
        return pLine[regexExp, 1]
      end

    #Class
    end

  # Ruby
  end
#Language
end
