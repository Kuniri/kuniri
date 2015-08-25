require_relative '../language'
require_relative '../container_data/structured_and_oo/class_data'
require_relative '../container_data/structured_and_oo/file_element_data'
require_relative 'token_{lang}'
require_relative 'extern_requirement_{lang}'
require_relative 'variable_global_{lang}'
require_relative 'module_namespace_{lang}'
require_relative 'end_block_{lang}'
require_relative 'constructor_{lang}'
require_relative 'class_{lang}'
require_relative 'conditional_{lang}'
require_relative 'repetition_{lang}'
require_relative 'function_behavior_{lang}'
require_relative 'attribute_{lang}'

module Languages

  # Handling the {LANG} syntax for extract information.
  class {LANG}Syntax < Languages::Language

    public

      def initialize
        super
        @externRequirementHandler = Languages::{LANG}::ExternRequirement{LANG}.new
        @variableHandler = Languages::{LANG}::VariableGlobal{LANG}.new
        @functionHandler = Languages::{LANG}::FunctionBehavior{LANG}.new
        @moduleHandler = Languages::{LANG}::ModuleNamespace{LANG}.new
        @classHandler = Languages::{LANG}::Class{LANG}.new
        @attributeHandler = Languages::{LANG}::Attribute{LANG}.new
        @endBlockHandler = Languages::{LANG}::EndBlock{LANG}.new
        @methodHandler = Languages::{LANG}::FunctionBehavior{LANG}.new
        @constructorHandler = Languages::{LANG}::Constructor{LANG}.new
        @conditionalHandler = Languages::{LANG}::Conditional{LANG}.new
        @repetitionHandler = Languages::{LANG}::Repetition{LANG}.new
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
        #Find a simple {LANG} comment with '#'
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

  # {LANG}
  end

# Module
end
