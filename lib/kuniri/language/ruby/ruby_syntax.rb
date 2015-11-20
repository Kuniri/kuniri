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
require_relative 'aggregation_ruby'
require_relative '../metadata'

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
        @aggregationHandler = Languages::Ruby::AggregationRuby.new
        @metadata = Languages::Metadata.create
        @visibility = "public"
      end

      # Analyse source code.
      # @param pPath Path of file to be analysed.
      def analyse_source(pPath)
        @name = File.basename(pPath, ".*")
        @path = File.dirname(pPath)
        analyse_first_step(pPath)
        analyse_second_step
      end

    private

      attr_accessor :visibility
      @source
      @flagMultipleLineComment = false

      # Puts every statement in a single line
      # @param pLine Line of the file to be analysed.
      def handle_semicolon(pLine)
        commentLine = []

        if pLine =~ /^=begin(.*?)/
          @flagMultipleLineComment = true
        elsif pLine =~ /^=end/
          @flagMultipleLineComment = false
        end

        unless @flagMultipleLineComment == true || pLine =~ /#(.*)/
          return pLine.split(/;/)
        end
        commentLine << pLine
      end

      # First step for analyse code, it is responsible for get only basic
      # informations.
      # @param pPath Path of file to be analysed.
      def analyse_first_step(pPath)
        fileElement = Languages::FileElementData.new(pPath)
        @source = File.open(pPath, "rb")
        @source.each do |line|
          next if line.gsub(/\s+/,"").size == 0
          processedLines = handle_semicolon(line)
          if !processedLines.nil?
            processedLines.each do |line|
              @state.handle_line(line)
              fileElement = @state.execute(fileElement, line)
            end
          end
        end

        @fileElements.push(fileElement)

      end

      def analyse_second_step

        sort_all_classes
        sort_all_aggregations
        sort_all_inheritances

        allActualAggregations = []

        @metadata.allAggregations.each do |element|
          if binary_search(@metadata.allClasses, element)
            allActualAggregations << element
          end
        end

        # TODO: Think how to improve.
        allActualInheritances = []

        @metadata.allInheritances.each do |element|
          if binary_search(@metadata.allClasses, element)
            allActualInheritances<<element
          end
        end

        @fileElements.each do |fileElement|
          fileElement.classes.each do |classes|
            classes.inheritance.each do |inheritance|
              include allActualInheritances.include? inheritance
                inheritance.isInProject = true
              end
            end
          end
        end

        @fileElements.each do |fileElement|
          fileElement.classes.each do |classes|
            classes.aggregations.delete_if do |aggregation|
              unless allActualAggregations.include? aggregation
                true
              end
            end
          end
        end
      end

      # TODO: Move it to utils
      def binary_search(pVector, pElement)
        pVector.bsearch {|obj| pElement.name <=> obj.name}
      end

      # TODO: Move it to utils
      def sort_all_classes
        @metadata.allClasses.sort! {|c1, c2| c1.name <=> c2.name}
      end

      # TODO: Move it to utils
      def sort_all_aggregations
        @metadata.allAggregations.sort! {|a1, a2| a1.name <=> a2.name}
        @metadata.allAggregations.uniq! {|a| a.name}
      end

      def sort_all_inheritances()
        @metadata.allInheritances.sort! {|a1, a2| a1.name <=> a2.name}
        @metadata.allInheritances.uniq! {|a| a.name}
      end
  # Class
  end

# Module
end
