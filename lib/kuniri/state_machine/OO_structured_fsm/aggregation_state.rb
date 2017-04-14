#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

require_relative 'oo_structured_state'

module StateMachine

  module OOStructuredFSM

    # Class responsible for handling aggregation state.
    class AggregationState < OOStructuredState
      def initialize(pLanguage)
        @language = pLanguage
      end

      # @see OOStructuredState
      def handle_line(pLine); end

      # @see OOStructuredState
      def class_capture
        @language.rewind_state
      end

      # @see OOStructuredState
      def execute(pElementFile, pLine)
        aggregationElement = @language.aggregationHandler.get_aggregation(pLine)

        if aggregationElement
          pElementFile.classes.last.aggregations.push aggregationElement
          @language.metadata.allAggregations.push aggregationElement
        end

        class_capture
        return pElementFile
      end
    end # End class
  end # End OOStructuredFSM
end # End StateMachine
