require_relative 'oo_structured_state'
require_relative '../../language/abstract_container/structured_and_oo/global_tokens.rb'

module StateMachine

  module OOStructuredFSM

    # Class responsible for handling conditional state.
    class BasicStructureState < OOStructuredState

      @language

      def initialize(pLanguage)
        @language = pLanguage
        @language.resetNested
        @whoami = "the fu@!+ nobody"
      end

      def handle_line(pLine)
        conditional = @language.conditionalHandler.get_conditional(pLine)
        repetition = @language.repetitionHandler.get_repetition(pLine)
        if conditional
          if isNestedStructure?(conditional.type)
            conditional_capture
          end
        elsif repetition
          if isNestedStructure?(repetition.type)
            repetition_capture
          end
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
      def aggregation_capture
        @language.set_state(@language.aggregationState)
      end

      # @see OOStructuredState
      def execute(pElementFile, pLine)
        flag = @language.flagFunctionBehaviour
        classIndex = pElementFile.classes.length - 1 # We want the index

        addBasicStructure(pLine, flag, classIndex, pElementFile)

        #if (@language.endBlockHandler.has_end_of_block?(pLine) || singleLine)
        if (@language.endBlockHandler.has_end_of_block?(pLine))
          updateLevel(flag, pElementFile, classIndex)
        end

        return pElementFile
      end

      protected

        @countNestedConditional
        @whoami

        def addBasicStructure(pLine, pFlag, pClassIndex, pElementFile)
          raise NotImplementedError
        end

        def isNestedStructure?(pType)
          raise NotImplementedError
        end

        def addToCorrectElement(pElement, pElementFile, pFlag, pClassIndex)
          elementType = pElement.type
          stringToEval = "classes[#{pClassIndex}]."
          case pFlag
            when StateMachine::GLOBAL_FUNCTION_STATE
              dynamicallyAdd(pElementFile, pElement,
                                    elementType, "global_functions")
            when StateMachine::METHOD_STATE
              dynamicallyAdd(pElementFile, pElement,
                                    elementType, stringToEval + "methods")
            when StateMachine::CONSTRUCTOR_STATE
              dynamicallyAdd(pElementFile, pElement,
                                elementType, stringToEval + "constructors")
          end
        end

        def updateLevel(pFlag, pElementFile, pClassIndex)
          case pFlag
            when StateMachine::GLOBAL_FUNCTION_STATE
              dynamicLevelUpdate(pElementFile, "global_functions")
            when StateMachine::METHOD_STATE
              stringMethod = "classes[#{pClassIndex}].methods"
              dynamicLevelUpdate(pElementFile, stringMethod)
            when StateMachine::CONSTRUCTOR_STATE
              stringMethod = "classes[#{pClassIndex}].constructors"
              dynamicLevelUpdate(pElementFile, stringMethod)
           end
          @language.rewind_state
          @language.lessNested
        end

        def dynamicallyAdd(pElementFile, pToAdd, pType, pElement)
          classIndex = pElementFile.classes.length - 1 # We want the index
          index = eval("pElementFile.#{pElement}.length - 1")
          if (@language.isNested? && isNestedStructure?(pType))
            eval("pElementFile.#{pElement}[index]." +
                  "managerCondAndLoop.down_level")
          end
          eval("pElementFile.#{pElement}[index].add_#{@whoami}(pToAdd)")
        end

        def dynamicLevelUpdate(pElementFile, pElement)
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
