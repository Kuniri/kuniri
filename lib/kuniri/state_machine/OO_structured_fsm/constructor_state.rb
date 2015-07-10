require_relative 'oo_structured_state.rb'

module StateMachine

  module OOStructuredFSM

    class ConstructorState < OOStructuredState

      @language

      def initialize(pLanguage)
        @language = pLanguage
      end

      def handle_line(pLine)
        if @language.conditionalHandler.get_conditional(pLine)
          conditional_capture
        elsif @language.repetitionHandler.get_repetition(pLine)
          repetition_capture
        else
          return
        end
      end

      def class_capture
        @language.rewind_state
      end

      def conditional_capture
        @language.flagFunctionBehaviour = StateMachine::CONSTRUCTOR_STATE
        @language.set_state(@language.conditionalState)
      end

      def repetition_capture
        @language.flagFunctionBehaviour = StateMachine::CONSTRUCTOR_STATE
        @language.set_state(@language.repetitionState)
      end

      def execute(pElementFile, pLine)
        constructorElement =
                          @language.constructorHandler.get_constructor(pLine)

        if (constructorElement)
          lastIndex = pElementFile.classes.length - 1 # We want the index
          pElementFile.classes[lastIndex].add_constructor(constructorElement)
        end

        if (@language.endBlockHandler.has_end_of_block?(pLine))
          class_capture
        end

        return pElementFile

      end
    
    # End class
    end

  # End OOStructuredFSM
  end

# End StateMachine
end
