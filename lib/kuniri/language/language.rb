# Module that keeps the language syntax.
module Languages
  # @abstract Abstract class for handling different types of language.
  class Language

    public
      # Set the source code to by analysed.
      # @param source [String] Set the source string.
      def set_source(source)
        @source = source
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

    protected

      @languageType
      @source
  end
end
