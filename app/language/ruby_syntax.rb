require_relative 'language'
require_relative 'ruby_syntax_support'
require_relative 'class_container'
require_relative 'method_container'

module Languages
  
  # Handling the ruby syntax for extract information. 
  class RubySyntax < Languages::Language
    
    public
      # Should I initialize it?
      @rubySyntaxSupport
      @currentClass
      attr_reader :visibility
      @source

      # TODO: TAKE CARE HERE!!! POTENTIAL EXCEPTION CAN RAISED HERE!
      def initialize(path)
        @rubySyntaxSupport = RubySyntaxSupport.new
        @currentClass = ClassContainer.new
        @visibility = "public"
        analyse_source(path)
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

      #
      # @param source [String]
      def global_variable_extract
        raise NotImplementedError
      end 

    private
      def analyse_first_step(path)
        @source = File.open(path, "rb")
        @source.each do |line|  
          tokenType = @rubySyntaxSupport.get_token_type(line)
          case tokenType
          when Languages::CLASS_TOKEN
            save_class(line)
            @rubySyntaxSupport.increment_token
          when Languages::ATTRIBUTE_TOKEN
            save_attribute(line)
          when Languages::METHOD_TOKEN
            save_method(line)
            @rubySyntaxSupport.increment_token
          when Languages::END_TOKEN
            @rubySyntaxSupport.decrement_token
          when Languages::VISIBILITY_TOKEN
            update_visibility(tokenType)
          else
            next
          end
        end
      end

      def save_class(line)
        # Regex in the line
        @currentClass.className = @rubySyntaxSupport.get_class_name(line)
        #if @rubySyntaxSupport.has_inheritance?
        #  @class.inheritance = @rubySyntaxSupport.get_inheritance(line)
        #end
      end

      def save_attribute(line)
        attribute = @rubySyntaxSupport.get_attribute(line)
        attribute.visibility = @visibility
        @currentClass.add_attribute(attribute)
      end

      def save_method(line)
        # get_method MUST TO RETURN A METHOD OBJECT
        method = @rubySyntaxSupport.get_method(line)
        method.visibility = @visibility
        @currentClass.add_method(method)
      end
      
      def update_visibility(line)
        visibility = @rubySyntaxSupport.get_visibiliy(line)
        @visibility = visibility
      end
  end
end
