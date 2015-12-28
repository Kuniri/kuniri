require_relative 'oo_structured_state'
require_relative '../../language/abstract_container/structured_and_oo/global_tokens.rb'

module StateMachine

  module OOStructuredFSM

    # Class responsible for handling conditional state.
    class ConditionalState < OOStructuredState

      MAP_STATE =
      {
        StateMachine::METHOD_STATE => StateMachine::METHOD_LABEL,
        StateMachine::CONSTRUCTOR_STATE => StateMachine::CONSTRUCTOR_LABEL,
        StateMachine::GLOBAL_FUNCTION_STATE => StateMachine::FUNCTION_LABEL
      }

      @language

      def initialize(pLanguage)
        @language = pLanguage
        @language.resetNested
      end

      def handle_line(pLine)
        if @language.conditionalHandler.get_conditional(pLine)
          conditional_capture
        elsif @language.repetitionHandler.get_repetition(pLine)
          repetition_capture
        # aggregation
        end
      end

      # @see OOStructuredState
      def method_capture
        @language.rewind_state
      end

      # @see OOStructuredState
      def constructor_capture
        @language.rewind_state
      end

      # @see OOStructuredState
      def function_capture
        @language.rewind_state
      end

      # @see OOStructuredState
      def repetition_capture
        @language.set_state(@language.repetitionState)
      end

      # @see OOStructuredState
      def conditional_capture
        @language.moreNested
        @language.set_state(@language.conditionalState)
      end

      # @see OOStructuredState
      def aggregation_capture
        @language.set_state(@language.aggregationState)
      end

      # @see OOStructuredState
      def execute(pElementFile, pLine)
        conditional = @language.conditionalHandler.get_conditional(pLine)
        flag = @language.flagFunctionBehaviour
        classIndex = pElementFile.classes.length - 1 # We want the index
        if (conditional)
          conditionalType = conditional.type
          if flag == StateMachine::GLOBAL_FUNCTION_STATE
            index = pElementFile.global_functions.length - 1
            if (@language.isNested? &&
                (conditionalType == Languages::IF_LABEL || conditionalType == Languages::CASE_LABEL))
              pElementFile.global_functions[index]
                                            .managerCondAndLoop.down_level
            end
            pElementFile.global_functions[index].add_conditional(conditional)
          elsif flag == StateMachine::METHOD_STATE
            index = pElementFile.classes[classIndex].methods.length - 1
            if (@language.isNested? &&
                (conditionalType == Languages::IF_LABEL || conditionalType == Languages::CASE_LABEL))
              pElementFile.classes[classIndex].methods[index]
                                            .managerCondAndLoop.down_level
            end
            pElementFile.classes[classIndex].methods[index]
                                            .add_conditional(conditional)
          elsif flag == StateMachine::CONSTRUCTOR_STATE
            index = pElementFile.classes[classIndex].constructors.length - 1
            if (@language.isNested? &&
                (conditionalType == Languages::IF_LABEL || conditionalType == Languages::CASE_LABEL))
              pElementFile.classes[classIndex].constructors[index]
                                            .managerCondAndLoop.down_level
            end
            pElementFile.classes[classIndex].constructors[index]
                                            .add_conditional(conditional)

          end
        end

        #if (@language.endBlockHandler.has_end_of_block?(pLine) || singleLine)
        if (@language.endBlockHandler.has_end_of_block?(pLine))
          @language.rewind_state
          @language.lessNested
          if flag == StateMachine::GLOBAL_FUNCTION_STATE
            index = pElementFile.global_functions.length - 1
            if @language.isNested?
              pElementFile.global_functions[index]
                                            .managerCondAndLoop.up_level
            end
          elsif flag == StateMachine::METHOD_STATE
            index = pElementFile.classes[classIndex].methods.length - 1
            if @language.isNested?
              pElementFile.classes[classIndex].methods[index]
                                            .managerCondAndLoop.up_level
            end
          elsif flag == StateMachine::CONSTRUCTOR_STATE
            if @language.isNested?
              pElementFile.classes[classIndex].methods[index]
                                            .managerCondAndLoop.up_level
            end
          end
        end

        return pElementFile
      end

      private

        @countNestedConditional

    # End class
    end

  # End OOStructuredFSM
  end

# End StateMachine
end
