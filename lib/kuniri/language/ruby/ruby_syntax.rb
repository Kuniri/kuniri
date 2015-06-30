require_relative '../language'
require_relative '../container_data/structured_and_oo/class_data'
require_relative '../container_data/structured_and_oo/file_element'
require_relative 'token_ruby'
require_relative 'extern_requirement_ruby'
require_relative 'variable_global_ruby'
require_relative 'module_namespace_ruby'
require_relative 'end_block_ruby'
require_relative 'constructor_ruby'
require_relative 'class_ruby'
require_relative 'conditional_ruby'
require_relative 'repetition_ruby'
require_relative 'function_behavior_ruby'
require_relative 'attribute_ruby'

module Languages

  # Handling the ruby syntax for extract information.
  class RubySyntax < Languages::Language

    public

      def initialize
        super
        @externRequirementHandler = Languages::Ruby::ExternRequirementRuby.new
        @variableHandler = Languages::Ruby::VariableGlobalRuby.new
        @functionHandler = Languages::Ruby::FunctionBehaviorRuby.new
        @moduleHandler = Languages::Ruby::ModuleNamespaceRuby.new
        @classHandler = Languages::Ruby::ClassRuby.new
        @attributeHandler = Languages::Ruby::AttributeRuby.new
        @endBlockHandler = Languages::Ruby::EndBlockRuby.new
        @methodHandler = Languages::Ruby::FunctionBehaviorRuby.new
        @constructorHandler = Languages::Ruby::ConstructorRuby.new
        @conditionalHandler = Languages::Ruby::ConditionalRuby.new
        @repetitionHandler = Languages::Ruby::RepetitionRuby.new
        clear_data
      end

      def clear_data
        #You have to make it more generic, for the situation of many class.
        @currentClass = Languages::ClassData.new
        @classes = []
        @visibility = "public"
        @class_token = 0
        @token = 0
        @attributeList = []
        @externRequirements = []
        @functionList = []
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
        @classes
      end

    private

      @class_token
      @token
      @rubySyntaxSupport
      @classes
      @currentClass
      @functionList
      attr_accessor :visibility
      @source
      @attributeList
      @externRequirements

      def analyse_first_step(pPath)
        fileElement = Languages::FileElement.new(pPath)
        @source = File.open(pPath, "rb")
        @source.each do |line|
          next if line.gsub(/\s+/,"").size == 0
          # Special token for class
          @state.handle_line(line)
          fileElement = @state.execute(fileElement, line)
        end
        @fileElements.push(fileElement)
      end

      def increase_token
        @token = @token + 1
      end

  # Class
  end

# Module
end
