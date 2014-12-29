# Module that keeps the language syntax.
module Languages
  # @abstract Abstract class for handling different types of language.
  class Language
    public

      # Extract all the comments from the source.
      # @param source [String] Source code to analys.
      def comment_extract(source)
        raise NotImplementedError
      end

      # Extract all the method/function from the source.
      # @param source [String]
      def method_extract(source)
        raise NotImplementedError
      end

      # Extract all the class declared in the source.
      # @param source [String]
      def class_extract(source)
        raise NotImplementedError
      end

      # Extract the attribute from source file.
      # @param source [String]
      def attribute_extract(source)
        raise NotImplementedError
      end

      # Extract global variables.
      # @param source [String]
      def global_variable_extract(source)
        raise NotImplementedError
      end

    protected
      @languageType
  end
end
