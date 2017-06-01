#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

require_relative 'oo_structured_state'
require_relative '../../language/abstract_container/'\
                 'structured_and_oo/global_tokens.rb'

module StateMachine

  module OOStructuredFSM

    # Class responsible for handling Basic structures state. Understand basic
    # basic structure by conditional and repetitions.
    class BasicStructureState < OOStructuredState

      # Initialize basic structure
      # Child class should OVERRIDE @whoAmI correctly
      def initialize(pLanguage)
        @language = pLanguage
        @language.reset_nested
        @whoAmI = 'the fu@!+ nobody'
      end

      def handle_line(pLine)
        # TODO: This line is complex, maybe it can be simple. However, notice
        # that line_inspect method is expensive, and should be called once.
        structures = {
          CONDITIONAL_ID => method(:conditional_capture),
          REPETITION_ID => method(:repetition_capture),
          BLOCK_ID => method(:block_capture)
        }

        structures.each do |id, function|
          structure_data = @language.line_inspect(id, pLine)
          unless structure_data.nil?
            function.call if nested_structure?(structure_data.type)
            break
          end
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
        @language.more_nested
        @language.set_state(@language.conditionalState)
      end

      # @see OOStructuredState
      def repetition_capture
        @language.more_nested
        @language.set_state(@language.repetitionState)
      end

      # @see OOStructuredState
      def block_capture
        @language.more_nested
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
        if (@language.endBlockHandler.end_of_block?(pLine) || singleLine)
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
        when Languages::LAMBDA_BLOCK_LABEL then return true
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
        if (@language.nested? && nested_structure?(pToAdd.type))
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
        @language.less_nested
      end

    end # End class
  end # End OOStructuredFSM
end # End StateMachine
