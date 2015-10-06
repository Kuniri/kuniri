require_relative '../language'
require_relative '../container_data/structured_and_oo/class_data'
require_relative '../container_data/structured_and_oo/file_element_data'
require_relative 'token_java'
require_relative 'extern_requirement_java'
require_relative 'variable_global_java'
require_relative 'module_namespace_java'
require_relative 'end_block_java'
require_relative 'constructor_java'
require_relative 'class_java'
require_relative 'conditional_java'
require_relative 'repetition_java'
require_relative 'function_behavior_java'
require_relative 'attribute_java'
require_relative 'comment_java'

module Languages

  # Handling the Java syntax for extract information.
  class JavaSyntax < Languages::Language

    public

      def initialize
        super
        @externRequirementHandler = Languages::Java::ExternRequirementJava.new
        @variableHandler = Languages::Java::VariableGlobalJava.new
        @functionHandler = Languages::Java::FunctionBehaviorJava.new
        @moduleHandler = Languages::Java::ModuleNamespaceJava.new
        @classHandler = Languages::Java::ClassJava.new
        @attributeHandler = Languages::Java::AttributeJava.new
        @endBlockHandler = Languages::Java::EndBlockJava.new
        @methodHandler = Languages::Java::FunctionBehaviorJava.new
        @constructorHandler = Languages::Java::ConstructorJava.new
        @conditionalHandler = Languages::Java::ConditionalJava.new
        @repetitionHandler = Languages::Java::RepetitionJava.new
        @commentHandler = Languages::Java::CommentJava.new
        @visibility = "public"
      end

      def analyse_source(pPath)
        @name = File.basename(pPath, ".*")
        @path = File.dirname(pPath)
        analyse_first_step(pPath)
        #self.analyse_second_step
      end

      # Extract all the comments from the source.
      # @param source [String] Source code to analys.
      def comment_extract
        all_comments = Array.new
        #Find a simple Java comment with '#'
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
        return @currentClass.get_methods
      end

      # Extract all the class declared in the source.
      # @param source [String]
      def class_extract
        return @currentClass
      end

      # @param source [String]
      def attribute_extract
        return @currentClass.get_attributes
      end

      # @param source [String]
      def global_variable_extract
        raise NotImplementedError
      end

      def extern_requirement_extract
        return @externRequirements
      end

      def get_classes
      end

    private

      attr_accessor :visibility
      @source

      def analyse_first_step(pPath)
        fileElement = Languages::FileElementData.new(pPath)
        @source = File.open(pPath, "rb")
        @source.each do |line|
          next if line.gsub(/\s+/,"").size == 0
          # Special token for class
          @state.handle_line(line)
          fileElement = @state.execute(fileElement, line)
        end
        @fileElements.push(fileElement)
      end

  # Java
  end

# Module
end
