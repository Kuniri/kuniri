require_relative 'output_format'
require_relative 'xml_builder_engine'

module Parser

  class XMLOutputFormat < OutputFormat

    public

      def initialize(pPath = "kuniri.xml")
        @outputEngine = XMLBuilderEngine.new
        set_path(pPath)
      end

      # Set path to save the output.
      # @param pPath Output path.
      def set_path(pPath)
        @parser_path = pPath
      end

      # @see OutputFormat
      def class_generate(pClass)
        pClass.each do |singleClass|
          @outputEngine.classData :name => singleClass.name do
            # TODO: Inheritance
            singleClass.attributes.each do |singleAttribute|
              attribute_generate(singleAttribute)
            end
            singleClass.constructors.each do |singleConstructor|
              constructor_generate(singleConstructor)
            end
            singleClass.methods.each do |singleMethod|
              method_generate(singleMethod)
            end
          end
        end
      end

      # @see OutputFormat
      def attribute_generate(pAttribute)
        pAttribute.each do |singleAttribute|
          @outputEngine.attributeData :name => singleAttribute.name,
                                      :visibility => singleAttribute.visibility
        end
      end

      # @see OutputFormat
      def inheritance_generate(pInheritances)
        pInheritances.each do |singleInheritance|
          @outputEngine.inheritanceData :name => singleInheritance.name
        end
      end

      # @see OutputFormat
      def constructor_generate(pConstructor)
        pConstructor.each do |singleConstructor|
          @outputEngine.constructorData :name => singleConstructor.name do
            if singleConstructor.comments != ""
              comment_generate(singleConstructor.comments)
            end
            singleConstructor.parameters.each do |parameter|
              parameter_generate(parameter)
            end
            singleConstructor.conditionals.each do |conditional|
              conditional_generate(conditional)
            end
            singleConstructor.repetitions.each do |repetition|
              repetition_generate(repetition)
            end
          end
        end
      end

      # @see OutputFormat
      def method_generate(pMethod)
puts "*"*30
        pMethod.each do |singleMethod|
          @outputEngine.methodData :name => singleMethod.name do
            if singleMethod.comments != ""
              comment_generate(singleMethod.comments)
            end
            singleMethod.parameters.each do |parameter|
              parameter_generate(parameter)
            end
            singleMethod.conditionals.each do |conditional|
              conditional_generate(conditional)
            end
            singleMethod.repetitions.each do |repetition|
              repetition_generate(repetition)
            end
          end
        end
      end

      # @see OutputFormat
      def function_generate(pFunction)
        pFunction.each do |singleFunction|
          @outputEngine.functionData :name => singleFunction.name do
            if singleFunction.comments != ""
              comment_generate(singleFunction.comments)
            end
            singleFunction.parameters.each do |parameter|
              parameter_generate(parameter)
            end
            singleFunction.conditionals.each do |conditional|
              conditional_generate(conditional)
            end
          end
        end
      end

      # @see OutputFormat
      def parameters_generate(pParameters)
        pParameters.each do |parameter|
          if parameter.is_a?Hash
            parameter.each do |nameParam, value|
              @outputEngine.parameterData :name => "#{nameParam}=#{value}"
            end
          elsif parameter.is_a?String
            @outputEngine.parameterData :name => parameter
          end
        end
      end

      # @see OutputFormat
      def global_variable_generate(pGlobalVariable)
        pGlobalVariable.each do |globalVar|
          @outputEngine.globalVariableData :name => globalVar.name
        end
      end

      # @see OutputFormat
      def extern_requirement_generate(pRequirement)
        pRequirement.each do |externRequirement|
          @outputEngine.externRequirementData :name => externRequirement.path
        end
      end

      # @see OutputFormat
      def module_generate(pModule)
        pModule.each do |singleModule|
          @outputEngine.moduleData :name => singleModule.name
        end
      end

      # @see OutputFormat
      def repetition_generate(pRepetition)
        pRepetition.each do |repetition|
          @outputEngine.repetitionData :name => repetition.name,
                                        :type => repetition.type,
                                        :expression => repetition.expression
        end
      end

      # @see OutputFormat
      def conditional_generate(pConditional)
        pConditional.each do |conditional|
          @outputEngine.conditionalData :name => conditional.name,
                                        :type => conditional.type,
                                        :expression => conditional.expression
        end
      end

      def comment_generate(pComment)
        @outputEngine.commentData :text => pComment
      end

  # class
  end

# module
end
