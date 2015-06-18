module Languages

  # Abstraction to handling namespace, module, package or anything similar.
  class ModuleNamespace

    public

      # @param pLine Receives a line for try to find module inside it.
      # @return Return an ModuleNamespaceData
      # Get a string and try to find a pattern, that match or not with module.
      def get_module(pLine)
        raise NotImplementedError
      end

    protected

      # @param pLine String for try to find a pattern.
      # @return Return an string pre-processed, or nil in case of not match
      #         string.
      # Detect module.
      def detect_module(pLine)
        raise NotImplementedError
      end

      # @param pLine Receives a line for handling.
      # @return 
      def remove_unnecessary_information(pLine)
        raise NotImplementedError
      end

  # class
  end

# Languages module
end
