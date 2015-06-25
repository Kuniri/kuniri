require_relative 'oo_structured_state.rb'

module StateMachine

  module OOStructuredFSM

    class ConditionalState < OOStructuredState

      @language

      def initialize(pLanguage)
        @language = pLanguage
      end

      def handle_line(pLine)
        # FROM HERE YOU CAN GO TO: IF, ELSE, WHILE, FOR, EACH...
      end

      def method_capture
        @language.rewind_state
      end

      def constructor_capture
        @language.rewind_state
      end

      def function_capture
        @language.rewind_state
      end

      def execute(pElementFile, pLine)
        conditional = @language.conditionalHandler.get_conditional(pLine)

        if (conditional)
          flag = @language.flagFunctionBehaviour

          #Function
          if (flag == Languages::GLOBAL_FUNCTION_STATE)
            pElementFile.global_functions.last.add_conditional(conditional)
          #Method
          elsif (flag == Languages::METHOD_STATE)
            pElementFile.classes.last.methods.last.add_conditional(conditional)
          #Constructor
          elsif (flag == Languages::CONSTRUCTOR_STATE)
            pElementFile.classes.last.constructors
                        .last.add_conditional(conditional)
          end
        end

        if (@language.endBlockHandler.has_end_of_block?(pLine))
          if (flag == Languages::GLOBAL_FUNCTION_STATE)
            function_capture
          elsif (flag == Languages::METHOD_STATE)
            method_capture
          elsif (flag == Languages::CONSTRUCTOR_STATE)
            constructor_capture
          end
        end

        return pElementFile

      end
    
    # End class
    end

  # End OOStructuredFSM
  end

# End StateMachine
end
