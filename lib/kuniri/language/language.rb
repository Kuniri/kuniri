#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

require_relative '../state_machine/OO_structured_fsm/attribute_state'
require_relative '../state_machine/OO_structured_fsm/class_state'
require_relative '../state_machine/OO_structured_fsm/constructor_state'
require_relative '../state_machine/OO_structured_fsm/function_state'
require_relative '../state_machine/OO_structured_fsm/idle_state'
require_relative '../state_machine/OO_structured_fsm/include_state'
require_relative '../state_machine/OO_structured_fsm/method_state'
require_relative '../state_machine/OO_structured_fsm/module_state'
require_relative '../state_machine/OO_structured_fsm/variable_state'
require_relative '../state_machine/OO_structured_fsm/oo_structured_state'
require_relative '../state_machine/OO_structured_fsm/conditional_state'
require_relative '../state_machine/OO_structured_fsm/repetition_state'
require_relative '../state_machine/OO_structured_fsm/block_state'
require_relative '../state_machine/OO_structured_fsm/comment_state'
require_relative '../state_machine/OO_structured_fsm/aggregation_state'
require_relative '../state_machine/OO_structured_fsm/token_state_machine'

# Module that keeps the language syntax.
module Languages

  # @abstract Abstract class for handling different types of language.
  class Language
    attr_reader :name
    attr_reader :path

    attr_reader :attributeState
    attr_reader :state
    attr_reader :previousState
    attr_reader :classState
    attr_reader :constructorState
    attr_reader :functionState
    attr_reader :idleState
    attr_reader :includeState
    attr_reader :methodState
    attr_reader :moduleState
    attr_reader :variableState
    attr_reader :conditionalState
    attr_reader :repetitionState
    attr_reader :blockState
    attr_reader :commentState
    attr_reader :aggregationState

    attr_reader :externRequirementHandler
    attr_reader :variableHandler
    attr_reader :functionHandler
    attr_reader :moduleHandler
    attr_reader :classHandler
    attr_reader :endBlockHandler
    attr_reader :attributeHandler
    attr_reader :methodHandler
    attr_reader :constructorHandler
    attr_reader :conditionalHandler
    attr_reader :repetitionHandler
    attr_reader :blockHandler
    attr_reader :commentHandler
    attr_reader :aggregationHandler

    attr_reader :metadata

    attr_accessor :fileElements

    # Those values help state machine to understand which place to add
    # conditional information and repetition data.
    attr_accessor :flagFunctionBehaviour

    attr_reader :countNestedCondLoop

    attr_accessor :string_comment_to_transfer

    attr_reader :processed_line

    # This method initialize all the needed states of state machine.
    # @note: Never forget to call this method before start parser.
    def initialize
      @attributeState =
        StateMachine::OOStructuredFSM::AttributeState.new(self)
      @classState = StateMachine::OOStructuredFSM::ClassState.new(self)
      @constructorState =
        StateMachine::OOStructuredFSM::ConstructorState.new(self)
      @functionState = StateMachine::OOStructuredFSM::FunctionState.new(self)
      @idleState = StateMachine::OOStructuredFSM::IdleState.new(self)
      @includeState = StateMachine::OOStructuredFSM::IncludeState.new(self)
      @methodState = StateMachine::OOStructuredFSM::MethodState.new(self)
      @moduleState = StateMachine::OOStructuredFSM::ModuleState.new(self)
      @variableState = StateMachine::OOStructuredFSM::VariableState.new(self)
      @conditionalState =
        StateMachine::OOStructuredFSM::ConditionalState.new(self)
      @repetitionState =
        StateMachine::OOStructuredFSM::RepetitionState.new(self)
      @blockState = StateMachine::OOStructuredFSM::BlockState.new(self)
      @commentState = StateMachine::OOStructuredFSM::CommentState.new(self)
      @aggregationState =
        StateMachine::OOStructuredFSM::AggregationState.new(self)

      initialize_fsm
      initialize_elements
    end

    # Set the source code to by analysed.
    # @param pSource [String] Set the source string.
    def set_source(pSource)
      @source = pSource
    end

    # Based on the source, extract the informations inside of it. For example
    # in this is step the algorithm try to find classes, and methods. This
    # method, work like a hook for give more flexibility to implements any
    # needed steps.
    def analyse_source(fileElement, source)
      analyse_first_step(fileElement, source)
      analyse_second_step
    end

    def analyse_first_step(_fileElement, _source)
      raise NotImplementedError
    end

    def analyse_second_step
      raise NotImplementedError
    end

    # Rewind state
    def rewind_state
      @state = @previousState.pop
    end

    # Handling line
    def handle_line(_pLine)
      @state.handle_line
    end

    # Handling class state, i.e, this state is enable when any class is match
    def class_capture
      @state.class_capture
    end

    # Handling method state, this state is enable only after class state.
    def method_capture
      @state.method_capture
    end

    # Handling constructor, only after class state.
    def constructor_capture
      @state.constructor_capture
    end

    # Handling attribute state.
    def attribute_capture
      @state.attribute_capture
    end

    # Handling module, it can be oriented object or structured.
    def module_capture
      @state.module_capture
    end

    # Handling function, it is related with structured state
    # but not exclusively.
    def function_capture
      @state.function_capture
    end

    # Handling external include
    def include_capture
      @state.include_capture
    end

    # Handling variable
    def variable_capture
      @state.variable_capture
    end

    # Idle state, waiting for action! =D
    def idle_capture
      @state.idle_capture
    end

    # Conditional state.
    def conditional_capture
      @state.conditional_capture
    end

    # Block state.
    def block_capture
      @state.block_capture
    end

    # Aggregation state.
    def aggregation_capture
      @state.aggregation_capture
    end

    # keep track of state.
    def set_state(pState)
      @previousState.push(@state)
      @state = pState
    end

    # Increase nested level
    def more_nested
      @countNestedCondLoop += 1
    end

    # Reduce nested level
    def less_nested
      @countNestedCondLoop -= 1 if @countNestedCondLoop.positive?
    end

    # Verify if is nested or not
    def nested?
      return true if @countNestedCondLoop.positive?
      return false
    end

    # Reset nested structure
    def reset_nested
      @countNestedCondLoop = 0
    end

    def build_structures
      { StateMachine::METHOD_ID =>
          @methodHandler.method(:get_method),
        StateMachine::CONSTRUCTOR_ID =>
          @constructorHandler.method(:get_constructor),
        StateMachine::FUNCTION_ID =>
          @functionHandler.method(:get_function),
        StateMachine::COMMENT_ID =>
          @commentHandler.method(:get_comment),
        StateMachine::VARIABLE_ID =>
          @variableHandler.method(:get_variable),
        StateMachine::MODULE_ID => @moduleHandler.method(:get_module),
        StateMachine::CLASS_ID => @classHandler.method(:get_class),
        StateMachine::REPETITION_ID =>
          @repetitionHandler.method(:get_repetition),
        StateMachine::CONDITIONAL_ID =>
          @conditionalHandler.method(:get_conditional),
        StateMachine::ATTRIBUTE_ID =>
          @attributeHandler.method(:get_attribute),
        StateMachine::BLOCK_ID =>
          @blockHandler.method(:get_block),
        StateMachine::AGGREGATION_ID =>
          @aggregationHandler.method(:get_aggregation),
        StateMachine::EXTERN_REQUIREMENT_ID =>
          @externRequirementHandler.method(:get_requirement) }
    end

    def line_inspect(pTarget, pLine)
      build_structures.each do |id, method|
        if pTarget == id
          @processed_line = method.call pLine
          break
        end
      end
      @processed_line
    end

    private

    # Initialize state machine attributes.
    def initialize_fsm
      @state = @idleState
      @previousState = []
      @previousState.push(@state)
      @flagFunctionBehaviour = nil
      @countNestedCondLoop = 0
    end

    # Initialize basic elements.
    def initialize_elements
      @fileElements = []
      @string_comment_to_transfer = ''
    end

  end # End class
end # End module
