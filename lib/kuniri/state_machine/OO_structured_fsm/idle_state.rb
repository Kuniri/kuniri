require_relative 'oo_structured_state.rb'

module StateMachine

  module OOStructuredFSM

    class IdleState < OOStructuredState

      @language

      def initialize(pLanguage)
        @language = pLanguage
      end

      def handle_line(pLine)
        # TODO: REMOVER: A IDEIA SERIA TER UM <XPTO>HANDLER NA CLASSE LANGUAGE
        # PARA CADA POSSÍVEL ESTADO, AÍ, QUEM HERDA PREENCHE ELES COM AS
        # CLASSES CERTAS! ASSIM EU CRIO UMA SUBCLASSE PARA CADA LINGUAGEM.
        if @language.externRequirementHandler.get_requirement(pLine)
          include_capture
        elsif @language.variableHandler.get_variable(pLine)
          variable_capture
        elsif @language.functionHandler.get_function(pLine)
          function_capture
        elsif @language.moduleHandler.get_module(pLine)
          module_capture
        elsif @language.classHandler.get_class(pLine)
          class_capture
        end
      end

      def include_capture
        # TODO: REMOVER: QUANDO ENTRAR NESTE MÉTODO ELE DEVE SALVAR O INCLUDE
        # FEITO.
        @language.set_state(@language.includeState)
      end

      def variable_capture
        @language.set_state(@language.variableState)
      end

      def function_capture
        @language.set_state(@language.functionState)
      end

      def module_capture
        @language.set_state(@language.moduleState)
      end

      def class_capture
        # @fileElement.add(@language.classHandler.get_class)
        @language.set_state(@language.classState)
      end

    # End class
    end

  # End OOStructuredFSM
  end

# End StateMachine
end
