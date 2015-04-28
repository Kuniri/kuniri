# Module that keeps the language syntax.
module Languages

  # @abstract Abstract class for handling different types of language.
  class Language

    public

      attr_reader :name
      attr_reader :path

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

    protected

      @languageType
      @source
      @attributeState
      @classState
      @constructorState
      @functionState
      @idleState
      @includeState
      @methodState
      @moduleState
      @variableState

  # End class
  end

# End module
end
