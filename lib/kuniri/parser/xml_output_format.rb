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
        # We use it because of the block below.
        wrapper = self
        pClass.each do |singleClass|
          @outputEngine.classData :name => singleClass.name,
                                  :visibility => singleClass.visibility do
            if singleClass.comments != ""
              wrapper.comment_generate(singleClass.comments)
            end
            #singleClass.attributes.each do |singleAttribute|
            #  attribute_generate(singleAttribute)
            #end
            singleClass.constructors.each do |singleConstructor|
              wrapper.constructor_generate(singleConstructor)
            end
            singleClass.methods.each do |singleMethod|
              wrapper.method_generate(singleMethod)
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
          @outputEngine.inheritanceData :name => singleInheritance
        end
      end

      # @see OutputFormat
      def constructor_generate(pConstructor)
        wrapper = self
        @outputEngine.constructorData :name => pConstructor.name,
                                      :visibility => pConstructor.visibility do
          if pConstructor.comments != ""
            wrapper.comment_generate(pConstructor.comments)
          end
          pConstructor.parameters.each do |parameter|
            wrapper.parameters_generate(parameter)
          end
          #singleConstructor.conditionals.each do |conditional|
          #  conditional_generate(conditional)
          #end
          #singleConstructor.repetitions.each do |repetition|
          #  repetition_generate(repetition)
          #end
        end
      end

      # @see OutputFormat
      def method_generate(pMethod)
        wrapper = self
        @outputEngine.methodData :name => pMethod.name,
                                  :visibility => pMethod.visibility do
          if pMethod.comments != ""
            wrapper.comment_generate(pMethod.comments)
          end
          pMethod.parameters.each do |parameter|
            wrapper.parameters_generate(parameter)
          end
          #pMethod.conditionals.each do |conditional|
          #  conditional_generate(conditional)
          #end
          #pMethod.repetitions.each do |repetition|
          #  repetition_generate(repetition)
          #end
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
              parameters_generate(parameter)
            end
            singleFunction.conditionals.each do |conditional|
              conditional_generate(conditional)
            end
          end
        end
      end

      # @see OutputFormat
      def parameters_generate(pParameters)
        if pParameters.is_a?Hash
          pParameters.each do |nameParam, value|
            @outputEngine.parameterData :name => "#{nameParam}=#{value}"
          end
        elsif pParameters.is_a?String
          @outputEngine.parameterData :name => pParameters
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
