require_relative 'oo_structured_state'
require_relative '../../language/abstract_container/structured_and_oo/global_tokens.rb'

module StateMachine

  module OOStructuredFSM

    # Class responsible for handling Basic structures state. Understand basic
    # basic structure by conditional and repetitions.
    class BasicStructureState < OOStructuredState

      @language

      def initialize(pLanguage)
        @language = pLanguage
        @language.resetNested
        @whoAmI = "the fu@!+ nobody"
      end

      def handle_line(pLine)
        conditional = @language.conditionalHandler.get_conditional(pLine)
        repetition = @language.repetitionHandler.get_repetition(pLine)
        block = @language.blockHandler.get_blocks(pLine)
        if conditional
          if isNestedStructure?(conditional.type)
            conditional_capture
          end
        elsif repetition
          if isNestedStructure?(repetition.type)
            repetition_capture
          end
        elsif block
          if isNestedStructure?(block.type)
            block_capture
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
      def conditional_capture
        @language.moreNested
        @language.set_state(@language.conditionalState)
      end

      # @see OOStructuredState
      def repetition_capture
        @language.moreNested
        @language.set_state(@language.repetitionState)
      end

      # @see OOStructuredState
      def block_capture
        @language.moreNested
        @language.set_state(@language.blockState)
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

        @whoAmI # !@param whoAmI Used for differentiated child class.

        # Add conditional or repetition. It is delegate to child class.
        # @param pLine Line to analyse
        # @param pFlag Flag for identify global function, constructor or method
        # @param pClassIndex Element index to add
        # @param pElementFile Element with all data
        def addBasicStructure(pLine, pFlag, pClassIndex, pElementFile)
          raise NotImplementedError
        end

        # If is a structure which can be nested. It is delegate.
        # @param pType Constant with type description.
        def isNestedStructure?(pType)
          if pType == Languages::WHILE_LABEL ||
              pType == Languages::FOR_LABEL ||
              pType == Languages::DO_WHILE_LABEL ||
              pType == Languages::UNTIL_LABEL ||
              pType == Languages::IF_LABEL ||
              pType == Languages::CASE_LABEL ||
              pType == Languages::UNLESS_LABEL ||
              pType == Languages::BLOCK_LABEL
            return true
          end
          return false

        end

        # Add element to correct place, based on the state machine position.
        # @pElement Specific element, e.g, conditional or repetition object.
        # @pElementFile All data.
        # @pFlag Flag with current position in the state machine.
        # @pClassIndex Index of class.
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

        # Update nested level in conditional or repetition.
        # @param pFlag
        # @param pElementFile
        # @param pClassIndex
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

        # Dynamically add based on child class.
        # @param pElementFile All data inside element.
        # @param pToAdd Element to add.
        # @param pType Type of thhe element.
        # @param pElement Element description.
        def dynamicallyAdd(pElementFile, pToAdd, pType, pElement)
          classIndex = pElementFile.classes.length - 1 # We want the index
          index = eval("pElementFile.#{pElement}.length - 1")
          if (@language.isNested? && isNestedStructure?(pType))
            eval("pElementFile.#{pElement}[index]." +
                  "managerCondAndLoop.down_level")
          end
          eval("pElementFile.#{pElement}[index].add_#{@whoAmI}(pToAdd)")
        end

        # Update level of conditional or repetition
        # @param pElementFile Element with all data.
        # @param pElement String name of the element.
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
