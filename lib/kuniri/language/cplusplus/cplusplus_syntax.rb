require_relative '../language'
require_relative '../container_data/structured_and_oo/class_data'
require_relative '../container_data/structured_and_oo/file_element_data'
require_relative 'token_cplusplus'
require_relative 'extern_requirement_cplusplus'
require_relative 'variable_global_cplusplus'
require_relative 'module_namespace_cplusplus'
require_relative 'end_block_cplusplus'
require_relative 'constructor_cplusplus'
require_relative 'class_cplusplus'
require_relative 'conditional_cplusplus'
require_relative 'repetition_cplusplus'
require_relative 'function_behavior_cplusplus'
require_relative 'attribute_cplusplus'
require_relative 'comment_cplusplus'

module Languages

  # Handling the Cplusplus syntax for extract information.
  class CplusplusSyntax < Languages::Language

    public

      def initialize
        super
        @externRequirementHandler = Languages::Cplusplus::ExternRequirementCplusplus.new
        @variableHandler = Languages::Cplusplus::VariableGlobalCplusplus.new
        @functionHandler = Languages::Cplusplus::FunctionBehaviorCplusplus.new
        @moduleHandler = Languages::Cplusplus::ModuleNamespaceCplusplus.new
        @classHandler = Languages::Cplusplus::ClassCplusplus.new
        @attributeHandler = Languages::Cplusplus::AttributeCplusplus.new
        @endBlockHandler = Languages::Cplusplus::EndBlockCplusplus.new
        @methodHandler = Languages::Cplusplus::FunctionBehaviorCplusplus.new
        @constructorHandler = Languages::Cplusplus::ConstructorCplusplus.new
        @conditionalHandler = Languages::Cplusplus::ConditionalCplusplus.new
        @repetitionHandler = Languages::Cplusplus::RepetitionCplusplus.new
        @commentHandler = Languages::Cplusplus::CommentCplusplus.new
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
        #Find a simple Cplusplus comment with '#'
        @source.scan(/\/\/(.*)/).each do |comments|
          all_comments.push(comments[0])
        end
        #Find multiple line comment.
        @source.scan(/\/\*(.*?)^\*\//m).each do |comment|
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

  # Cplusplus
  end

# Module
end
