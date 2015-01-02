require_relative 'language'

module Languages
  # Handling the ruby syntax for extract information. 
  class RubySyntax < Languages::Language

    public   
      # Extract all the comments from the source.
      # @param source [String] Source code to analys.
      def comment_extract
        all_comments = Array.new
        #@source.to_enum(:scan,/(#|=begin)/i).map do |matched,|
        #  all_comments_location[$`.size] = matched
        #end
        #Find a simple Ruby comment with '#'
        @source.scan(/#(.*)/).each do |comments|
          all_comments.push(comments)
        end
        #Find multiple line comment.
        @source.scan(/[^ \t](=begin[.\n]*)(((?!\1).[\n]?)*)([^ \t]=end)/).each do |comment|
          all_comments.push(comment) if (comment != "=begin") or (comment != "=end")
        end

        return all_comments
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
