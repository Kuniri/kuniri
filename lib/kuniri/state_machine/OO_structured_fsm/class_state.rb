require_relative 'oo_structured_state.rb'

module StateMachine

  module OOStructuredFSM

    class ClassState < OOStructuredState

      @language

      def initialize (pLanguage)
        @language = pLanguage
      end

      def handle_line(pLine)
        if @language.attributeHandler.get_attribute(pLine)
          attribute_capture
        # TODO: UNCOMMENT IT, after you implement it.
        # elsif @language.constructorHandler.get_constructor(pLine)
        #  constructor_capture
        elsif @language.methodHandler.get_function(pLine)
          method_capture
        elsif @language.moduleHandler.get_module(pLine)
          module_capture
        end
      end

      def method_capture
        @language.set_state(@language.methodState)
      end

      def constructor_capture
        @language.set_state(@language.constructorState)
      end

      def attribute_capture
        @language.set_state(@language.attributeState)
      end

      def module_capture
        @language.rewind_state
      end

      def idle_capture
        @language.rewind_state
      end 

      def execute(pElementFile, pLine)
        classElement = @language.classHandler.get_class(pLine)

        if classElement
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
