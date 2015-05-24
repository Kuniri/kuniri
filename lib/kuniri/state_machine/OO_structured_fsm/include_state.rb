require_relative 'oo_structured_state.rb'

module StateMachine

  module OOStructuredFSM

    class IncludeState < OOStructuredState

      @language

      def initialize(pLanguage)
        @language = pLanguage
      end

      def handle_line(pLine)
        # TODO: REMOVE: PRECISO PENSAR MELHOR NESTES CASOS QUE O ESTADO É 
        # PASSAGEIRO.
        if @language.idleHandler.get_idle(pLine)
          idle_capture
        #else
        # TODO: CONTINUA NO ESTDO.
        end
      end

      def idle_capture
        @language.set_state(@language.idleState)
      end

    # End class
    end

  # End OOStructuredFSM
  end

# End StateMachine
end
