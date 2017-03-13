#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

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
        @whoAmI = 'the fu@!+ nobody'
      end

      def handle_line(pLine)
        if ! (conditional = @language.line_inspect(CONDITIONAL_ID, pLine)).nil?
          conditional_capture if isNestedStructure?(conditional.type)
        elsif ! (repetition = @language.line_inspect(REPETITION_ID, pLine)).nil?
          repetition_capture if isNestedStructure?(repetition.type)
        elsif ! (block = @language.line_inspect(BLOCK_ID, pLine)).nil?
          block_capture if isNestedStructure?(block.type)
        # aggregation
        end
      end

      # @see OOStructuredState
      def idle_capture
        @language.rewind_state
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
        classIndex = pElementFile.get_last_class_index
        addBasicStructure(pLine, flag, classIndex, pElementFile)

        element = @language.processed_line
        singleLineFlag = element.nil? ? false : element.singleLine

        if (@language.endBlockHandler.has_end_of_block?(pLine) || singleLineFlag)
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
          element = @language.processed_line
          if (element)
            addToCorrectElement(element, pElementFile, pFlag, pClassIndex)
          end
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
              dynamicallyAdd(pElementFile, pElement, elementType,
                             'global_functions')
            when StateMachine::METHOD_STATE
              dynamicallyAdd(pElementFile, pElement, elementType,
                             stringToEval + 'methods')
            when StateMachine::CONSTRUCTOR_STATE
              dynamicallyAdd(pElementFile, pElement, elementType,
                             stringToEval + 'constructors')
            when StateMachine::CONDITIONAL_STATE
              pElementFile.add_conditional(pElement)
            when StateMachine::REPETITION_STATE
              pElementFile.add_repetition(pElement)
            when StateMachine::BLOCK_STATE
              pElementFile.add_block(pElement)
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
            when StateMachine::CONDITIONAL_STATE
              dynamicLevelUpdate(pElementFile, 'conditionals')
            when StateMachine::REPETITION_STATE
              dynamicLevelUpdate(pElementFile, 'repetitions')
            when StateMachine::BLOCK_STATE
              dynamicLevelUpdate(pElementFile, 'blocks')
          end
          @language.rewind_state
          @language.lessNested
        end

        # Dynamically add based on child class.
        # @param pElementFile All data inside element.
        # @param pToAdd Element to add.
        # @param pType Type of the element.
        # @param pElement Element description.
        def dynamicallyAdd(pElementFile, pToAdd, pType, pElement)
          classIndex = pElementFile.get_last_class_index
          index = eval("pElementFile.#{pElement}.length - 1")
          if (@language.isNested? && isNestedStructure?(pType))
            eval("pElementFile.#{pElement}[index]." +
                  'managerCondAndLoop.down_level')
          end
          eval("pElementFile.#{pElement}[index].add_#{@whoAmI}(pToAdd)")
        end

        # Update level of conditional or repetition
        # @param pElementFile Element with all data.
        # @param pElement String name of the element.
        def dynamicLevelUpdate(pElementFile, pElement)
          if @language.isNested?
            target = "pElementFile.#{pElement}[pElementFile.#{pElement}" +
                     ".length - 1].managerCondAndLoop.up_level"
            eval(target)
          end
       end

    end # End class
  end # End OOStructuredFSM
end # End StateMachine
