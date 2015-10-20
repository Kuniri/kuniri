require_relative '../language'
require_relative '../container_data/structured_and_oo/class_data'
require_relative '../container_data/structured_and_oo/file_element_data'
require_relative 'token_csharp'
require_relative 'extern_requirement_csharp'
require_relative 'variable_global_csharp'
require_relative 'module_namespace_csharp'
require_relative 'end_block_csharp'
require_relative 'constructor_csharp'
require_relative 'class_csharp'
require_relative 'conditional_csharp'
require_relative 'repetition_csharp'
require_relative 'function_behavior_csharp'
require_relative 'attribute_csharp'
require_relative 'comment_csharp'

module Languages

  # Handling the Csharp syntax for extract information.
  class CsharpSyntax < Languages::Language

    public

      def initialize
        super
        @externRequirementHandler = Languages::Csharp::ExternRequirementCsharp.new
        @variableHandler = Languages::Csharp::VariableGlobalCsharp.new
        @functionHandler = Languages::Csharp::FunctionBehaviorCsharp.new
        @moduleHandler = Languages::Csharp::ModuleNamespaceCsharp.new
        @classHandler = Languages::Csharp::ClassCsharp.new
        @attributeHandler = Languages::Csharp::AttributeCsharp.new
        @endBlockHandler = Languages::Csharp::EndBlockCsharp.new
        @methodHandler = Languages::Csharp::FunctionBehaviorCsharp.new
        @constructorHandler = Languages::Csharp::ConstructorCsharp.new
        @conditionalHandler = Languages::Csharp::ConditionalCsharp.new
        @repetitionHandler = Languages::Csharp::RepetitionCsharp.new
        @commentHandler = Languages::Csharp::CommentCsharp.new
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
        #Find a simple Csharp comment with '#'
        @source.scan(/\/\/(.*)/).each do |comments|
          all_comments.push(comments[0])
        end
        #Find multiple line comment.
        @source.scan(/^\/\*(.*?)^\*\//m).each do |comment|
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
      @flagMultipleLineComment = false

      # Puts every statement in a single line
      # @param pLine Line of the file to be analysed.
      def handle_semicolon(pLine)
        commentLine = []

        if pLine =~ /^\/\*(.*?)/
          @flagMultipleLineComment = true
        elsif pLine =~ /^\/\*/
          @flagMultipleLineComment = false
        end

        unless @flagMultipleLineComment == true || pLine =~ /\/\/(.*)/
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

  # Csharp
  end

# Module
end
