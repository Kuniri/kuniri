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
require_relative 'comment_{lang}'
require_relative 'method_{lang}'
require_relative 'aggregation_{lang}'
require_relative '../metadata'

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
        @methodHandler = Languages::{LANG}::Method{LANG}.new
        @constructorHandler = Languages::{LANG}::Constructor{LANG}.new
        @conditionalHandler = Languages::{LANG}::Conditional{LANG}.new
        @repetitionHandler = Languages::{LANG}::Repetition{LANG}.new
        @commentHandler = Languages::{LANG}::Comment{LANG}.new
        @aggregationHandler = Languages::{LANG}::Aggregation{LANG}.new
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

        @source.close()
        @fileElements.push(fileElement)

      end

      def analyse_second_step
        sort_all_classes
        sort_all_aggregations

        allActualAggregations = []

        @metadata.allAggregations.each do |element|
          if binary_search(@metadata.allClasses, element)
            allActualAggregations << element
          end
        end

        # TODO: Think how to improve.
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

  # Class
  end

# Module
end
