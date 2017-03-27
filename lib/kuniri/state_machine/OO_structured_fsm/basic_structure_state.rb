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

      # Initialize basic structure
      # Child class should OVERRIDE @whoAmI correctly
      def initialize(pLanguage)
        @language = pLanguage
        @language.resetNested
        @whoAmI = 'the fu@!+ nobody'
      end

      def handle_line(pLine)
        # TODO: This line is complex, maybe it can be simple. However, notice
        # that line_inspect method is expensive, and should be called once.
        if !(conditional = @language.line_inspect(CONDITIONAL_ID, pLine)).nil?
          conditional_capture if nested_structure?(conditional.type)
        elsif !(repetition = @language.line_inspect(REPETITION_ID, pLine)).nil?
          repetition_capture if nested_structure?(repetition.type)
        elsif !(block = @language.line_inspect(BLOCK_ID, pLine)).nil?
          block_capture if nested_structure?(block.type)
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
        add_to_correct_element(pElementFile, flag, classIndex)

        element = @language.processed_line
        singleLine = element.nil? ? false : element.singleLine
        if (@language.endBlockHandler.has_end_of_block?(pLine) || singleLine)
          update_level(flag, pElementFile, classIndex)
        end
        return pElementFile
      end

      protected

      # If is a structure which can be nested. It is delegate.
      # @param pType Constant with type description.
      def nested_structure?(pType)
        case pType
        when Languages::WHILE_LABEL then return true
        when Languages::FOR_LABEL then return true
        when Languages::DO_WHILE_LABEL then return true
        when Languages::UNTIL_LABEL then return true
        when Languages::IF_LABEL then return true
        when Languages::CASE_LABEL then return true
        when Languages::UNLESS_LABEL then return true
        when Languages::BLOCK_LABEL then return true
        else
          return false
        end
      end

      # Add element to correct place, based on the state machine position.
      # @pElementFile All data structure
      # @pFlag Flag with current position in the state machine
      # @pClassIndex Index of class
      def add_to_correct_element(pElementFile, pFlag, pClassIndex)
        element = @language.processed_line || return

        case pFlag
        when StateMachine::GLOBAL_FUNCTION_STATE
          target = pElementFile.global_functions.last
          attach_element(target, element)
        when StateMachine::METHOD_STATE
          target = pElementFile.classes[pClassIndex].methods.last
          attach_element(target, element)
        when StateMachine::CONSTRUCTOR_STATE
          target = pElementFile.classes[pClassIndex].constructors.last
          attach_element(target, element)
        when StateMachine::SCRIPT_STATE
          attach_element(pElementFile, element)
        end
      end

      # Dynamically add based on child class.
      # @param pTarget All data inside element.
      # @param pToAdd Element to add.
      def attach_element(pTarget, pToAdd)
        if (@language.isNested? && nested_structure?(pToAdd.type))
          pTarget.managerCondLoopAndBlock.increase_deep_level
        end
        pTarget.send("add_#{@whoAmI}", pToAdd)
      end

      # Update nested level in conditional or repetition.
      # @param pFlag
      # @param pElementFile
      # @param pClassIndex
      def update_level(pFlag, pElementFile, pClassIndex)
        case pFlag
        when StateMachine::GLOBAL_FUNCTION_STATE
          target = pElementFile.global_functions.last
        when StateMachine::METHOD_STATE
          target = pElementFile.classes[pClassIndex].methods.last
        when StateMachine::CONSTRUCTOR_STATE
          target = pElementFile.classes[pClassIndex].constructors.last
        when StateMachine::SCRIPT_STATE
          target = pElementFile
        end
        target.managerCondLoopAndBlock.decrease_deep_level
        @language.rewind_state
        @language.lessNested
      end

    end # End class
  end # End OOStructuredFSM
end # End StateMachine
