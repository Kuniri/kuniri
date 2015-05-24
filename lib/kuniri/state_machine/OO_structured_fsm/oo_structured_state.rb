# Responsible for keep different state machines.
module StateMachine

  # Responsible for handling oriented object and structured paradigm.
  module OOStructuredFSM

    # @abstract State machine for oriented object and structured paradigm.
    class OOStructuredState

      def handle_line(pLine)
        raise NotImplementedError
      end

      # Handling class state, i.e, this state is enable when any class is match
      def class_capture
        raise NotImplementedError
      end

      # Handling method state, this state is enable only after class state.
      def method_capture
        raise NotImplementedError
      end

      # Handling constructor, only after class state.
      def constructor_capture
        raise NotImplementedError
      end

      # Handling attribute state.
      def attribute_capture
        raise NotImplementedError
      end

      # Handling module, it can be oriented object or structured.
      def module_capture
        raise NotImplementedError
      end

      # Handling function, it is related with structured state
      # but not exclusively.
      def function_capture
        raise NotImplementedError
      end

      # Handling external include
      def include_capture
        raise NotImplementedError
      end

      # Handling variable
      def variable_capture
        raise NotImplementedError
      end

      # Idle state, waiting for action! =D
      def idle_capture
        raise NotImplementedError
      end

    # End class
    end

  # End OOStructuredState
  end

# End StateMachine
end
