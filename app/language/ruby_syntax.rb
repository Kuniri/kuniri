require_relative 'language'

module Languages
  # Handling the ruby syntax for extract information. 
  class RubySyntax < Languages::Language

    public   
      # Extract all the comments from the source.
      # @param source [String] Source code to analys.
      def comment_extract
        all_comments = Array.new
        #Find a simple Ruby comment with '#'
        @source.scan(/#(.*)/).each do |comments|
          all_comments.push(comments[0])
        end
        #Find multiple line comment.
        @source.scan(/^=begin(.*?)^=end/m).each do |comment|
          all_comments.push(comment[0].lstrip)
        end
        return all_comments
      end

      # Extract all the method/function from the source.
      # @param source [String]
      def method_extract
        all_methods = Array.new
        @source.scan(/\bdef\b\b[ |\t]+\s*(.*)\b/).each do |method|
          all_methods.push(method[0])
        end
        return all_methods
      end

      # Extract all the class declared in the source.
      # @param source [String]
      def class_extract
        all_class_name = Array.new
        @source.scan(/\bclass\b\b[ |\t]+\s*(.*)\b/).each do |nameClass|
          all_class_name.push(nameClass[0])
        end
        return all_class_name
      end

      #
      # @param source [String]
      def attribute_extract
        raise NotImplementedError
      end

      #
      # @param source [String]
      def global_variable_extract
        raise NotImplementedError
      end
  end
end
