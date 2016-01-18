require_relative 'oo_structured_state'
require_relative '../../language/abstract_container/structured_and_oo/global_tokens.rb'

module StateMachine

  module OOStructuredFSM

    # Class responsible for handling Repetition state.
    class RepetitionState < OOStructuredState

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
        repetition = @language.repetitionHandler.get_repetition(pLine)
        if repetition
          if isNestedRepetition?(repetition.type)
            repetition_capture
          end
        elsif @language.conditionalHandler.get_conditional(pLine)
          conditional_capture
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
      def conditional_capture
        @language.set_state(@language.conditionalState)
      end

      # @see OOStructuredState
      def repetition_capture
        @language.moreNested
        @language.set_state(@language.repetitionState)
      end

      # @see OOStructuredState
      def execute(pElementFile, pLine)
        repetition = @language.repetitionHandler.get_repetition(pLine)
        flag = @language.flagFunctionBehaviour
        classIndex = pElementFile.classes.length - 1
        if (repetition)
          addRepetitionToCorrectElement(repetition, pElementFile,
                                        classIndex, flag)
        end

        if (@language.endBlockHandler.has_end_of_block?(pLine))
          updateLevel(flag, pElementFile, classIndex)
        end

        return pElementFile
      end

      private

        @countNestedRepetition

        def isNestedRepetition?(pType)
          if pType == Languages::WHILE_LABEL || pType == Languages::FOR_LABEL ||
              pType == Languages::DO_WHILE_LABEL ||
              pType == Languages::UNTIL_LABEL
            return true
          end
          return false
        end

        def addRepetitionToCorrectElement(pRepetition, pElementFile,
                                          pClassIndex, pFlag)
          repetitionType = pRepetition.type
          stringToEval = "classes[#{pClassIndex}]."
          case pFlag
            when StateMachine::GLOBAL_FUNCTION_STATE
              dynamicAddRepetition(pElementFile, pRepetition,
                                    repetitionType, "global_functions")
            when StateMachine::METHOD_STATE
              dynamicAddRepetition(pElementFile, pRepetition,
                                    repetitionType, stringToEval + "methods")
            when StateMachine::CONSTRUCTOR_STATE
              dynamicAddRepetition(pElementFile, pRepetition,
                                repetitionType, stringToEval + "constructors")
          end
        end

        def updateLevel(pFlag, pElementFile, pClassIndex)
          case pFlag
            when StateMachine::GLOBAL_FUNCTION_STATE
              dynamicRepetitionLevelUpdate(pElementFile, "global_functions")
            when StateMachine::METHOD_STATE
              stringMethod = "classes[#{pClassIndex}].methods"
              dynamicRepetitionLevelUpdate(pElementFile, stringMethod)
            when StateMachine::CONSTRUCTOR_STATE
              stringConstructor = "classes[#{pClassIndex}].constructors"
              dynamicRepetitionLevelUpdate(pElementFile, stringConstructor)
          end
          @language.rewind_state
          @language.lessNested
        end

        def dynamicAddRepetition(pElementFile, pRepetition, pType, pElement)
          classIndex = pElementFile.classes.length - 1 # We want the index
          index = eval("pElementFile.#{pElement}.length - 1")
          if (@language.isNested? && isNestedRepetition?(pType))
            eval("pElementFile.#{pElement}[index]." +
                  "managerCondAndLoop.down_level")
          end
          eval("pElementFile.#{pElement}[index].add_repetition(pRepetition)")
        end

        def dynamicRepetitionLevelUpdate(pElementFile, pElement)
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
