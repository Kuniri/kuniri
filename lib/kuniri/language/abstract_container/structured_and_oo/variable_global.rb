module Languages

  # @abstract Any global variable should be handler here.
  class VariableGlobal

      public

        def initialize(pVariableBehaviour, pRegex)
          @whoAmI = 'variable'
          @detectRegex = pRegex
          @variableBehaviour = pVariableBehaviour
        end

        # This method is the main interface for extract data from specific
        # code and convert it to a common representation.
        # @param pLine Line to be inspected.
        # @return If line has a variable, this method returns an object of
        #       VariableGlobalData. Otherwise returns nil.
        # @see variable_global_data.rb
        def get_variable(pLine)
          @variableBehaviour.common_declaration(pLine, @detectRegex)
        end

      protected

        @whoAmI
        @variableBehaviour
        @detectRegex

        # Detect if line has attribute.
        # @param pLine Line with potential attribute.
        # @return Return a matched STRING or nil if not found.
        def detect_variable(pLine)
          raise NotImplementedError
        end

  # class
  end

# module
end
