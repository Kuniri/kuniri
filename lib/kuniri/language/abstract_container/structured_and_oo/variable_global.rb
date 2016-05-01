module Languages

  # @abstract Any global variable should be handler here.
  class VariableGlobal

      public

        # This method is the main interface for extract data from specific
        # code and convert it to a common representation.
        # @param pLine Line to be inspected.
        # @return If line has a variable, this method returns an object of
        #       VariableGlobalData. Otherwise returns nil.
        # @see variable_global_data.rb
        def get_variable(pLine)
          raise NotImplementedError
        end

      protected

        # Verify if line has a variable.
        # @param pLine String to be analysed.
        # @return Returns a partial string, if it can be a variable. Otherwise
        #       return nil.
        def detect_variable(pLine)
          raise NotImplementedError
        end

        # Handling value to assign to global variable.
        # @param pString String with value.
        # @return Return string.
        def handle_value(pString)
          raise NotImplementedError
        end

  # class
  end

# module
end
