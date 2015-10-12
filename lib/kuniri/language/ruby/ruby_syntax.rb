require_relative '../language'
require_relative '../container_data/structured_and_oo/class_data'
require_relative '../container_data/structured_and_oo/file_element_data'
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
require_relative 'comment_ruby'
require_relative 'method_ruby'

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
        @methodHandler = Languages::Ruby::MethodRuby.new
        @constructorHandler = Languages::Ruby::ConstructorRuby.new
        @conditionalHandler = Languages::Ruby::ConditionalRuby.new
        @repetitionHandler = Languages::Ruby::RepetitionRuby.new
        @commentHandler = Languages::Ruby::CommentRuby.new
        @visibility = "public"
      end

      # Analyse source code.
      # @param pPath Path of file to be analysed.
      def analyse_source(pPath)
        @name = File.basename(pPath, ".*")
        @path = File.dirname(pPath)
        analyse_first_step(pPath)
        #self.analyse_second_step
      end

    private

      attr_accessor :visibility
      @source

      # First step for analyse code, it is responsible for get only basic
      # informations.
      # @param pPath Path of file to be analysed.
      def analyse_first_step(pPath)
        fileElement = Languages::FileElementData.new(pPath)
        @source = File.open(pPath, "rb")
        @source.each do |line|
          next if line.gsub(/\s+/,"").size == 0

          @state.handle_line(line)
          fileElement = @state.execute(fileElement, line)
        end
        @fileElements.push(fileElement)
      end

  # Class
  end

# Module
end
