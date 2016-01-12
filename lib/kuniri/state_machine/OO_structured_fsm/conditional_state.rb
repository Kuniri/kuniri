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
        conditional = @language.conditionalHandler.get_conditional(pLine)
        if conditional
          if isANestedConditional?(conditional.type)
            conditional_capture
          end
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
          case flag
            when StateMachine::GLOBAL_FUNCTION_STATE
              dynamicAddConditional(pElementFile, conditional,
                                    conditionalType, "global_functions")
            when StateMachine::METHOD_STATE
# TODO: Use dynamicAddConditional here in the same way of GLOBAL_FUNCTION_STATE
#             t = "classes[#{classIndex}].methods"
#             dynamicAddConditional(pElementFile, conditional, conditionalType, t, classIndex)
              index = pElementFile.classes[classIndex].methods.length - 1
              if (@language.isNested? && isANestedConditional?(conditionalType))
                pElementFile.classes[classIndex].methods[index]
                                              .managerCondAndLoop.down_level
              end
              pElementFile.classes[classIndex].methods[index]
                                              .add_conditional(conditional)
            when StateMachine::CONSTRUCTOR_STATE
              index = pElementFile.classes[classIndex].constructors.length - 1
              if (@language.isNested? && isANestedConditional?(conditionalType))
                pElementFile.classes[classIndex].constructors[index]
                                              .managerCondAndLoop.down_level
              end
              pElementFile.classes[classIndex].constructors[index]
                                              .add_conditional(conditional)
          end
        end

        #if (@language.endBlockHandler.has_end_of_block?(pLine) || singleLine)
        if (@language.endBlockHandler.has_end_of_block?(pLine))
          case flag
            when StateMachine::GLOBAL_FUNCTION_STATE
              index = pElementFile.global_functions.length - 1
              if @language.isNested?
                pElementFile.global_functions[index]
                                              .managerCondAndLoop.up_level
              end
            when StateMachine::METHOD_STATE
              index = pElementFile.classes[classIndex].methods.length - 1
              if @language.isNested?
                pElementFile.classes[classIndex].methods[index]
                                              .managerCondAndLoop.up_level
              end
            when StateMachine::CONSTRUCTOR_STATE
              if @language.isNested?
                pElementFile.classes[classIndex].methods[index]
                                              .managerCondAndLoop.up_level
              end
           end
          @language.rewind_state
          @language.lessNested
        end

        return pElementFile
      end

      private

        @countNestedConditional

        def isANestedConditional?(pType)
          if pType == Languages::IF_LABEL ||
              pType == Languages::CASE_LABEL ||
              pType == Languages::UNLESS_LABEL
            return true
          end
          return false
        end

        def dynamicAddConditional(pElementFile, pConditional, pType, pElement)
          classIndex = pElementFile.classes.length - 1 # We want the index
          index = pElementFile.send(pElement).length - 1
          if (@language.isNested? && isANestedConditional?(pType))
            pElementFile.send(pElement)[index].managerCondAndLoop.down_level
          end
          pElementFile.send(pElement)[index].add_conditional(pConditional)
        end

    # End class
    end

  # End OOStructuredFSM
  end

# End StateMachine
end
