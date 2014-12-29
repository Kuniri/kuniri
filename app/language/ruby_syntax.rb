require_relative 'language'

module Languages
  # Handling the ruby syntax for extract information. 
  class RubySyntax < Languages::Language
    def initialize
    end

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

      #
      # @param source [String]
      def attribute_extract(source)
        raise NotImplementedError
      end

      #
      # @param source [String]
      def global_variable_extract(source)
        raise NotImplementedError
      end   
  end
end
