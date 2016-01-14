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
          addConditionalToCorrectElement(conditional, pElementFile,
                                          classIndex, flag)
        end

        #if (@language.endBlockHandler.has_end_of_block?(pLine) || singleLine)
        if (@language.endBlockHandler.has_end_of_block?(pLine))
          updateLevel(flag, pElementFile, classIndex)
        end

        return pElementFile
      end

      private

        @countNestedConditional

        def isANestedConditional?(pType)
          if pType == Languages::IF_LABEL || pType == Languages::CASE_LABEL ||
              pType == Languages::UNLESS_LABEL
            return true
          end
          return false
        end

        def addConditionalToCorrectElement(pConditional, pElementFile,
                                            pClassIndex, pFlag)
          conditionalType = pConditional.type
          stringToEval = "classes[#{pClassIndex}]."
          case pFlag
            when StateMachine::GLOBAL_FUNCTION_STATE
              dynamicAddConditional(pElementFile, pConditional,
                                    conditionalType, "global_functions")
            when StateMachine::METHOD_STATE
              dynamicAddConditional(pElementFile, pConditional,
                                    conditionalType, stringToEval + "methods")
            when StateMachine::CONSTRUCTOR_STATE
              dynamicAddConditional(pElementFile, pConditional,
                                conditionalType, stringToEval + "constructors")
          end
        end

        def updateLevel(pFlag, pElementFile, pClassIndex)
          case pFlag
            when StateMachine::GLOBAL_FUNCTION_STATE
              dynamicConditionalLevelUpdate(pElementFile, "global_functions")
            when StateMachine::METHOD_STATE
              stringMethod = "classes[#{pClassIndex}].methods"
              dynamicConditionalLevelUpdate(pElementFile, stringMethod)
            when StateMachine::CONSTRUCTOR_STATE
              stringMethod = "classes[#{pClassIndex}].constructors"
              dynamicConditionalLevelUpdate(pElementFile, stringMethod)
           end
          @language.rewind_state
          @language.lessNested
        end

        def dynamicAddConditional(pElementFile, pConditional, pType, pElement)
          classIndex = pElementFile.classes.length - 1 # We want the index
          index = eval("pElementFile.#{pElement}.length - 1")
          if (@language.isNested? && isANestedConditional?(pType))
            eval("pElementFile.#{pElement}[index]." +
                  "managerCondAndLoop.down_level")
          end
          eval("pElementFile.#{pElement}[index].add_conditional(pConditional)")
        end

        def dynamicConditionalLevelUpdate(pElementFile, pElement)
         index = eval("pElementFile.#{pElement}.length - 1")
         if @language.isNested?
           eval("pElementFile.#{pElement}[index].managerCondAndLoop.up_level")
         end
       end

    # End class
    end

  # End OOStructuredFSM
  end

# End StateMachine
end
