#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

require_relative 'output_format'
require_relative 'xml_builder_engine'

module Parser

  class XMLOutputFormat < OutputFormat
    def initialize(pOptimizationLevel = 0, pPath = 'outputKuniri/')
      @optimizationLevel = pOptimizationLevel
      @outputEngine = XMLBuilderEngine.new(2, @optimizationLevel)
      set_path(pPath)
    end

    # @see OutputFormat
    def class_generate(pClass)
      # We use it because of the block below.
      wrapper = self
      pClass.each do |singleClass|
        @outputEngine.classData name: singleClass.name,
                                visibility: singleClass.visibility do
          methods_counter = 0
          wrapper.comment_generate(singleClass)

          wrapper.handle_aggregations(singleClass.aggregations)
          wrapper.inheritance_generate(singleClass.inheritances)
          wrapper.handle_attributes(singleClass.attributes)

          singleClass.constructors.each do |singleConstructor|
            wrapper.function_behaviour_generate('constructorData',
                                                singleConstructor)
          end
          singleClass.methods.each do |singleMethod|
            wrapper.function_behaviour_generate('methodData', singleMethod)
            methods_counter += 1
          end
          wrapper.methods_counter_generate(methods_counter)
        end
      end
    end

    def methods_counter_generate(counter)
      @outputEngine.send('totalMethods', counter: counter)
    end

    def handle_aggregations(aggregations)
      aggregation_generate(aggregations) unless aggregations.empty?
    end

    def handle_attributes(attributes)
      attribute_generate(attributes) unless attributes.empty?
    end

    def class_counter_generate(pLength)
      @outputEngine.send('totalClasses', counter: pLength)
    end

    def loc_generate(pLoc)
      @outputEngine.send('linesOfCode', counter: pLoc)
    end

    # @see OutputFormat
    def function_behaviour_generate(pElementName, pFunction)
      wrapper = self
      @outputEngine.send(pElementName, name: pFunction.name,
                                       visibility: pFunction.visibility) do
        wrapper.comment_generate(pFunction)

        pFunction.parameters.each do |parameter|
          wrapper.parameters_generate(parameter)
        end
        unless pFunction.managerCondLoopAndBlock.basicStructure.empty?
          wrapper.basic_structure_generate(
            pFunction.managerCondLoopAndBlock.basicStructure
          )
        end
      end
    end

    def function_counter_generate(pNumberOfFunctions)
      @outputEngine.send('totalGlobalFunctions',
                         counter: pNumberOfFunctions)
    end

    # @see OutputFormat
    def parameters_generate(pParameters)
      if pParameters.is_a?Hash
        pParameters.each do |nameParam, value|
          @outputEngine.parameterData name: "#{nameParam}=#{value}"
        end
      elsif pParameters.is_a?String
        @outputEngine.parameterData name: pParameters
      end
    end

    # @see OutputFormat
    def global_variable_generate(pGlobalVariable)
      pGlobalVariable.each do |globalVar|
        if globalVar.value != Languages::UNKNOWN
          @outputEngine.globalVariableData name: globalVar.name,
                                           value: globalVar.value
        else
          @outputEngine.globalVariableData name: globalVar.name
        end
      end
    end

    # @see OutputFormat
    def attribute_generate(pAttribute)
      pAttribute.each do |singleAttribute|
        if singleAttribute.value != Languages::UNKNOWN
          @outputEngine.attributeData name: singleAttribute.name,
                                      value: singleAttribute.value,
                                      visibility: singleAttribute.visibility
        else
          @outputEngine.attributeData name: singleAttribute.name,
                                      visibility: singleAttribute.visibility
        end
      end
    end

    # @see OutputFormat
    def inheritance_generate(pInheritances)
      pInheritances.each do |singleInheritance|
        @outputEngine.inheritanceData name: singleInheritance
      end
    end

    # @see OutputFormat
    def extern_requirement_generate(pRequirement)
      pRequirement.each do |externRequirement|
        @outputEngine.externRequirementData name:
            externRequirement.library
      end
    end

    # @see OutputFormat
    def module_generate(pModule)
      pModule.each do |singleModule|
        @outputEngine.moduleData name: singleModule.name
      end
    end

    # @see OutputFormat
    def basic_structure_generate(pBasicStructure)
      pBasicStructure.each do |element|
        if element.type == Languages::ELSE_LABEL
          @outputEngine.send(element.type.downcase,
                             level: element.level)
        elsif element.type == Languages::LAMBDA_BLOCK_LABEL
          @outputEngine.send(element.type.downcase,
                             expression: element.expression,
                             level: element.level,
                             parameters: element.parameters.join(','))
        else
          @outputEngine.send(element.type.downcase,
                             expression: element.expression,
                             level: element.level)
        end
      end
    end

    def comment_generate(pElement)
      return if pElement.comments == ''
      @outputEngine.commentData text: pElement.comments.tr('"', "'")
    end

    def aggregation_generate(pAggregation)
      pAggregation.each do |aggregation|
        @outputEngine.aggregationData name: aggregation.name
      end
    end
  end # class
end # module
