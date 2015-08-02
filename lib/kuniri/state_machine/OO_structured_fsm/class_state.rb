require_relative 'oo_structured_state'

module StateMachine

  module OOStructuredFSM

    # Class responsible for handling class state.
    class ClassState < OOStructuredState

      @language

      def initialize (pLanguage)
        @language = pLanguage
      end

      # @see OOStructuredState
      def handle_line(pLine)
        if @language.attributeHandler.get_attribute(pLine)
          attribute_capture
        elsif @language.constructorHandler.get_constructor(pLine)
          constructor_capture
        elsif @language.methodHandler.get_function(pLine)
          method_capture
        elsif @language.moduleHandler.get_module(pLine)
          module_capture
        elsif @language.commentHandler.is_single_line_comment?(pLine) ||
              @language.commentHandler.is_multiple_line_comment?(pLine)
          comment_capture
        end
      end

      # @see OOStructuredState
      def method_capture
        @language.set_state(@language.methodState)
      end

      # @see OOStructuredState
      def constructor_capture
        @language.set_state(@language.constructorState)
      end

      # @see OOStructuredState
      def attribute_capture
        @language.set_state(@language.attributeState)
      end

      # @see OOStructuredState
      def module_capture
        @language.rewind_state
      end

      # @see OOStructuredState
      def idle_capture
        @language.rewind_state
      end

      # @see OOStructuredState
      def comment_capture
        @language.set_state(@language.commentState)
      end

      # @see OOStructuredState
      def execute(pElementFile, pLine)
        classElement = @language.classHandler.get_class(pLine)

        if classElement
          classElement.comments = @language.string_comment_to_transfer
          @language.string_comment_to_transfer = ""
          pElementFile.add_class(classElement)
        end
 
        if @language.endBlockHandler.has_end_of_block?(pLine)
          previous = @language.previousState.last

          if (previous.is_a? (StateMachine::OOStructuredFSM::IdleState))
            idle_capture
          elsif (previous.is_a? (StateMachine::OOStructuredFSM::ModuleState))
            module_capture
          else
            return pElementFile
          end
        end

        return pElementFile
      end

    # End class
    end

  # End OOStructuredFSM
  end

# 
end
