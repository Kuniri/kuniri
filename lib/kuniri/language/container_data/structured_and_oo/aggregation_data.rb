#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

require_relative 'basic_data'

module Languages

  # Handling aggregations data.
  class AggregationData < Languages::BasicData

    public

      # Basic initialization of aggregation.
      # @param pAggregationName Aggregation name for basic initialization.
      def initialize (pAggregationName)
        return nil if pAggregationName.nil? or !pAggregationName.is_a? String

        @name = pAggregationName
        @isInProject = false
      end

  # Class
  end

# Module
end
