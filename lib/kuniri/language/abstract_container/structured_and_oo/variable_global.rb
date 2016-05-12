module Languages

  # @abstract Any global variable should be handler here.
  class VariableGlobal

      public

        def initialize
          @whoAmI = 'variable'
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

        def setup_attribute(pVariableBehaviour, pRegex)
          @detectRegex = pRegex if is_regex?(pRegex)
          @variableBehaviour = pVariableBehaviour
        end

      protected

        @whoAmI
        @variableBehaviour
        @detectRegex

        def is_regex?(pRegex)
          return pRegex.instance_of?Regexp
        end

  # class
  end

# module
end
