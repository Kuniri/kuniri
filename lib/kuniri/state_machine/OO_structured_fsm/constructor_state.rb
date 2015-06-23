require_relative 'oo_structured_state.rb'

module StateMachine

  module OOStructuredFSM

    class ConstructorState < OOStructuredState

      @language

      def initialize(pLanguage)
        @language = pLanguage
      end

      def handle_line(pLine)
        # FROM HERE YOU CAN GO TO: IF, ELSE, WHILE, FOR, EACH...
      end

      def class_capture
        @language.rewind_state
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
