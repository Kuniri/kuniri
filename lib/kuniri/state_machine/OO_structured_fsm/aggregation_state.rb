require_relative 'oo_structured_state'

module StateMachine

  module OOStructuredFSM

    # Class responsible for handling aggregation state.
    class AggregationState < OOStructuredState

      @language

      def initialize(pLanguage)
        @language = pLanguage
      end

      # @see OOStructuredState
      def handle_line(pLine)
      end

      # @see OOStructuredState
      def class_capture
        @language.rewind_state
      end

      # @see OOStructuredState
      def execute(pElementFile, pLine)
        aggregationElement = @language.aggregationHandler.get_aggregation(pLine)

        if aggregationElement
            pElementFile.classes.last.aggregations.push aggregationElement
            # @metadata.allAggregations.push aggregationElement
        end

        class_capture
        return pElementFile
      end

    # End class
    end

  # End OOStructuredFSM
  end

# End StateMachine
end
