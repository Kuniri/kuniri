require_relative 'output_format'
require_relative 'xml_builder_engine'

module Parser

  class XMLOutputFormat < OutputFormat

    public

      def initialize(pPath = 'outputKuniri/')
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
            wrapper.inheritance_generate(singleClass.inheritances)
            unless singleClass.attributes.empty?
              wrapper.attribute_generate(singleClass.attributes)
            end
            singleClass.constructors.each do |singleConstructor|
              wrapper.function_behaviour_generate('constructorData',
                                                  singleConstructor)
            end
            singleClass.methods.each do |singleMethod|
              wrapper.function_behaviour_generate('methodData' , singleMethod)
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
          unless pFunction.managerCondAndLoop.basicStructure.empty?
            wrapper.basic_structure_generate(
                                  pFunction.managerCondAndLoop.basicStructure)
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
          if globalVar.value != 'nothing'
            @outputEngine.globalVariableData :name => globalVar.name,
                                              :value => globalVar.value
          else
            @outputEngine.globalVariableData :name => globalVar.name
          end
        end
      end

      # @see OutputFormat
      def attribute_generate(pAttribute)
        pAttribute.each do |singleAttribute|
          if singleAttribute.value != 'nothing'
            @outputEngine.attributeData :name => singleAttribute.name,
                                    :value => singleAttribute.value,
                                    :visibility => singleAttribute.visibility
          else
            @outputEngine.attributeData :name => singleAttribute.name,
                                      :visibility => singleAttribute.visibility
          end
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
      def basic_structure_generate(pBasicStructure)
        simple_element(pBasicStructure)
      end

      def simple_element(pElement)
        pElement.each do |element|
          if element.type == Languages::ELSE_LABEL
            @outputEngine.send(element.type.downcase,
                              {:level => element.level})
          else
            @outputEngine.send(element.type.downcase,
                              {:expression => element.expression,
                               :level => element.level})
          end
        end
      end

      def comment_generate(pElement)
        if pElement.comments != ''
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
