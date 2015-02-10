require_relative 'language'
require_relative 'ruby_syntax_support'
require_relative 'class_data'

module Languages

  # Handling the ruby syntax for extract information.
  class RubySyntax < Languages::Language

    public

      def initialize
        @rubySyntaxSupport = Languages::RubySyntaxSupport.new
        #You have to make it more generic, for the case of many class.
        @currentClass = Languages::ClassData.new
        @classes = []
        @visibility = "public"
        @class_token = 0
        @token = 0
      end
  
      def analyse_source(path)
        analyse_first_step(path)
        #self.analyse_second_step
      end
 
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

      # Extract all method from the source.
      # @param source [String]
      def method_extract
        return @currentClass.methods
      end

      # Extract all the class declared in the source.
      # @param source [String]
      def class_extract
        return @currentClass
      end

      # @param source [String]
      def attribute_extract
        return @currentClass.attributes
      end

      # @param source [String]
      def global_variable_extract
        raise NotImplementedError
      end

    private

      @class_token
      @token
      @rubySyntaxSupport
      @classes
      @currentClass
      attr_accessor :visibility
      @source

      def analyse_first_step(path)
        @source = File.open(path, "rb")
        @source.each do |line|  
          tokenType = @rubySyntaxSupport.get_token_type(line)
          if tokenType == Languages::CLASS_TOKEN || @class_token > 0
            handle_class(tokenType, line)
          else
            handle_nonclass(line)
          end
        end
      end

      def handle_class(tokenType, line)
        case tokenType
          when Languages::CLASS_TOKEN
            save_class(line)
            @class_token = @class_token + 1
            @token = @token + 1
            puts "> CLASS TOKEN"
          when Languages::ATTRIBUTE_TOKEN
            save_attribute(line)
            puts "= ATTRIBUTE TOKEN"
          when Languages::DEF_TOKEN
            save_method(line)
            @token = @token + 1
            puts "+ Method token"
          when Languages::END_TOKEN
            @token = @token - 1
          when Languages::VISIBILITY_TOKEN
            update_visibility(line)
            puts "- VISIBILITY"
          else
            return
          end
      end

      def handle_nonclass(line)
        return line
      end

      def save_class(line)
        # Regex in the line
        @currentClass.name = @rubySyntaxSupport.get_class_name(line)
        @classes.push(@currentClass)
        # Get inherintance
      end

      def save_attribute(line)
        attribute_name = @rubySyntaxSupport.get_attribute(line)
        attribute = Languages::AttributeData.new(attribute_name)
        @currentClass.add_attribute(attribute)
        @currentClass.visibility = @visibility
      end

      def save_method(line)
        # get_method MUST TO RETURN A METHOD OBJECT
        method_name = @rubySyntaxSupport.get_method(line)
        method = Languages::MethodData.new(method_name)
        @currentClass.add_method(method)
        @currentClass.visibility = @visibility
      end
 
      def update_visibility(line)
        @visibility = @rubySyntaxSupport.get_visibiliy(line)
      end
  end
end
