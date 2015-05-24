require_relative '../state_machine/OO_structured_fsm/attribute_state.rb'
require_relative '../state_machine/OO_structured_fsm/class_state.rb'
require_relative '../state_machine/OO_structured_fsm/constructor_state.rb'
require_relative '../state_machine/OO_structured_fsm/function_state.rb'
require_relative '../state_machine/OO_structured_fsm/idle_state.rb'
require_relative '../state_machine/OO_structured_fsm/include_state.rb'
require_relative '../state_machine/OO_structured_fsm/method_state.rb'
require_relative '../state_machine/OO_structured_fsm/module_state.rb'
require_relative '../state_machine/OO_structured_fsm/variable_state.rb'
require_relative '../state_machine/OO_structured_fsm/oo_structured_state.rb'

# Module that keeps the language syntax.
module Languages

  # @abstract Abstract class for handling different types of language.
  class Language

    public

      attr_reader :name
      attr_reader :path

      attr_reader :attributeState
      attr_reader :state
      attr_reader :classState
      attr_reader :constructorState
      attr_reader :functionState
      attr_reader :idleState
      attr_reader :includeState
      attr_reader :methodState
      attr_reader :moduleState
      attr_reader :variableState

      attr_reader :externRequirementHandler
      attr_reader :variableHandler
      attr_reader :functionHandler
      attr_reader :moduleHandler
      attr_reader :classHandler

      # @param pReference Reference of child class.
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
        @state = @idleState
      end

      # Set the source code to by analysed.
      # @param source [String] Set the source string.
      def set_source(pSource)
        @source = pSource
      end

      # Based on the source, extract the informations inside of it. For example
      # in this is step the algorithm try to find classes, and methods. This
      # method, work like a hook for give more flexibility to implements any
      # needed steps.
      def analyse_source
        raise NotImplementedError
      end
 
      # Extract all the comments from the source.
      # @param source [String] Source code to analys.
      def comment_extract
        raise NotImplementedError
      end

      # Extract all the method/function from the source.
      # @param source [String]
      def method_extract
        raise NotImplementedError
      end

      # Extract all the class declared in the source.
      # @param source [String]
      def class_extract
        raise NotImplementedError
      end

      # Extract the attribute from source file.
      # @param source [String]
      def attribute_extract
        raise NotImplementedError
      end

      # Extract global variables.
      # @param source [String]
      def global_variable_extract
        raise NotImplementedError
      end

      # Take all the extern requirements
      # @return Return an array with all the requirements.
      def extern_requirement_extract
        raise NotImplementedError
      end

      def get_name
        return @name
      end

      def get_path
        return @path
      end

      # Handling line
      def handle_line(pLine)
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

      def set_state (pState)
        @state = pState
      end

    protected

      @languageType
      @source
      
  # End class
  end

# End module
end
