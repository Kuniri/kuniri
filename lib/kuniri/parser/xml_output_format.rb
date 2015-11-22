require_relative 'output_format'
require_relative 'xml_builder_engine'

module Parser

  class XMLOutputFormat < OutputFormat

    public

      def initialize(pPath = "outputKuniri/")
        @outputEngine = XMLBuilderEngine.new
        set_path(pPath)
      end

      # @see OutputFormat
      def class_generate(pClass)
        # We use it because of the block below.
        wrapper = self
        pClass.each do |singleClass|
          @outputEngine.classData :name => singleClass.name,
                                  :visibility => singleClass.visibility do
            wrapper.comment_generate(singleClass)

            unless singleClass.aggregations.empty?
              wrapper.aggregation_generate(singleClass.aggregations)
            end
            singleClass.inheritances.each do |singleInheritance|
              wrapper.inheritance_generate(singleInheritance)
            end
            unless singleClass.attributes.empty?
              wrapper.attribute_generate(singleClass.attributes)
            end
            singleClass.constructors.each do |singleConstructor|
              wrapper.function_behaviour_generate("constructorData",
                                                  singleConstructor)
            end
            singleClass.methods.each do |singleMethod|
              wrapper.function_behaviour_generate("methodData" , singleMethod)
            end
          end
        end
      end

      # @see OutputFormat
      def function_behaviour_generate(pElementName, pFunction)
        wrapper = self
        @outputEngine.send(pElementName, {:name => pFunction.name,
                                      :visibility => pFunction.visibility}) do
          wrapper.comment_generate(pFunction)

          pFunction.parameters.each do |parameter|
            wrapper.parameters_generate(parameter)
          end
          unless pFunction.conditionals.empty?
            wrapper.conditional_generate(pFunction.conditionals)
          end
          unless pFunction.repetitions.empty?
            wrapper.repetition_generate(pFunction.repetitions)
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
      def extern_requirement_generate(pRequirement)
        pRequirement.each do |externRequirement|
          @outputEngine.externRequirementData :name =>
              externRequirement.library
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
        simple_element(pRepetition, "repetitionData")
      end

      # @see OutputFormat
      def conditional_generate(pConditional)
        simple_element(pConditional, "conditionalData")
      end

      def simple_element(pElement, pElementName)
        pElement.each do |element|
          finalExpression = element.expression.gsub('"', "'")
                                              .gsub('&', '&amp;')
                                              .gsub('>', '&gt;')
                                              .gsub('<', '&lt;')
          @outputEngine.send(pElementName,
                              {:name => element.name,
                               :type => element.type,
                               :expression => finalExpression})
        end
      end

      def comment_generate(pElement)
        if pElement.comments != ""
          @outputEngine.commentData :text => pElement.comments.gsub('"', "'")
        end
      end

      def aggregation_generate(pAggregation)
        pAggregation.each do |aggregation|
          @outputEngine.aggregationData :name => aggregation.name
        end
      end

  # class
  end

# module
end
