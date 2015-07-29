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

        # Remove unnecessary information.
        # @param pLine String to be improved.
        # @return Return an partial string, or the same if no work is needed.
        def remove_unnecessary_information(pLine)
          raise NotImplementedError
        end

        # Make some prunes and adjustments in the string.
        # @param pLine String to be prepared.
        # @return Return a string.
        def prepare_final_string(pLine)
          raise NotImplementedError
        end

        # Handling multiple line declaration with comma.
        # @param pString String with multiple declaration with comma.
        # @return Return a string.
        def handle_multiple_declaration_with_comma(pString)
          raise NotImplementedError
        end

        # Handling multiple declaration with equal.
        # @param pString String to be handled.
        # @return Return an array with all variables.
        def handle_multiple_declaration_with_equal(pString)
          raise NotImplementedError
        end

        # Handling simple line declaration.
        # @param pString String with simple declaration.
        # @return Return a string.
        def handle_line_declaration(pString)
          raise NotImplementedError
        end

  # class
  end

# module
end
