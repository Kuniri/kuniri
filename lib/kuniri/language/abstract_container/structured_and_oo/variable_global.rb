module Languages

  # @class VariableGlobal
  #
  # Any global variable should be handler here.
  class VariableGlobal

      public

        # @param pLine Line to be inspected.
        # @return If line has a variable, this method returns an object of
        #       VariableGlobalData. Otherwise returns nil.
        # @see variable_global_data.rb
        # This method is the main interface for extract data from specific code
        # and convert it to a common representation. 
        def get_variable(pLine)
          raise NotImplementedError
        end

      protected

        # @param pLine String to be analysed.
        # @return Return an partial string, if it can be a variable. Otherwise
        #       return nil.
        def detect_variable(pLine)
          raise NotImplementedError
        end

        # @param pLine String to be improved.
        # @return Return an partial string, or the same if no work is needed.
        def remove_unnecessary_information(pLine)
          raise NotImplementedError
        end

        def prepare_final_string(line)
          raise NotImplementedError
        end

        def handle_multiple_declaration_with_comma(pString)
          raise NotImplementedError
        end

        def handle_multiple_declaration_with_equal(pString)
          raise NotImplementedError
        end

        def handle_line_declaration(pString)
          raise NotImplementedError
        end

  # class
  end

# module
end
