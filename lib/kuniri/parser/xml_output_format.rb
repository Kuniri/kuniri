require_relative 'output_format'

module Parser

  class XMLOutputFormat < OutputFormat

    public

      # @see OutputFormat
      def class_generate(pClass)
        buildClassString = ""

        # Special case, empty class.
        if (pClass.inheritances.empty? && pClass.attributes.empty? &&
            pClass.methods.empty? && pClass.constructors.empty?)
          return default_fields("class", pClass)
        end

        buildClassString = default_fields("class", pClass, false)

        # Go through elements
        # 1 - Inheritances
        temporaryStringXML = inheritance_generate(pClass.inheritances)
        buildClassString += temporaryStringXML if temporaryStringXML
        # 2 - Attributes
        temporaryStringXML = attribute_generate(pClass.attributes)
        buildClassString += temporaryStringXML if temporaryStringXML
        # 3 - Constructors
        temporaryStringXML = constructor_generate(pClass.constructors)
        buildClassString += temporaryStringXML if temporaryStringXML
        # 4 - Methods
        temporaryStringXML = method_generate(pClass.methods)
        buildClassString += temporaryStringXML if temporaryStringXML
        # 5 - TODO: You have to handler class inside class

        # Close class
        buildClassString += "\n</class>"

        return buildClassString
      end

      # @see OutputFormat
      def constructor_generate(pConstructor)
        buildConstructorStringXML = ""
        # Special case, empty constructor
        if (pConstructor.parameters.empty? &&
            pConstructor.conditionals.empty? &&
            pConstructor.repetitions.empty?)
            return default_fields("constructor", pConstructor)
        end

        buildConstructorStringXML += default_fields("constructor",
                                                    pConstructor, false)

        # 1 - Handle parameters
        temporaryStringXML = parameters_generate(pConstructor)
        buildConstructorStringXML += temporaryStringXML if temporaryStringXML
        # 2 - Conditional
        temporaryStringXML = conditional_generate(pConstructor)
        buildConstructorStringXML += temporaryStringXML if temporaryStringXML
        # 3 - Repetition
        buildConstructorStringXML += temporaryStringXML if temporaryStringXML
        # 4 - TODO: local variable

        buildConstructorStringXML += "\n</constructor>"
        return buildConstructorStringXML

      end

      # @see OutputFormat
      def inheritance_generate(pInheritances)
        inheritanceString = []
        pInheritances.each do |inheritance|
          inheritanceString.push("<inheritance name=\"#{inheritance}\" />")
        end
        return inheritanceString.join("\n")
      end

      # @see OutputFormat
      def method_generate(pMethod)
        # Empty method
        if (pMethod.parameters.empty? && pMethod.conditionals.empty? &&
            pMethod.repetitions.empty?)
            return default_fields("method", pMethod)
        end

         default_fields("method", pMethod, false)

        # 1 - Handle parameters
        temporaryStringXML = parameters_generate(pConstructor.parameters)
        buildConstructorStringXML += temporaryStringXML if temporaryStringXML
        # 2 - Conditional
        temporaryStringXML = conditional_generate(pConstructor)
        buildConstructorStringXML += temporaryStringXML if temporaryStringXML
        # 3 - Repetition
        buildConstructorStringXML += temporaryStringXML if temporaryStringXML
        # 4 - TODO: local variable

        buildConstructorStringXML += "\n</constructor>"
        return buildConstructorStringXML
      end

      # @see OutputFormat
      def parameters_generate(pParameters)
        buildParameterString = []
        pParameters.each do |parameter|
           buildParameterString.push("<parameter name=\"#{parameter}\">")
        end
        return buildParameterString.join("\n")
      end

      # @see OutputFormat
      def attribute_generate(pAttribute)
        buildParameterString = []
        pAttribute.each do |attribute|    
          buildAttributeString.push("<attribute name=\"#{attribute}\">")
        end
        return buildAttributeString.join("\n")
      end

      # @see OutputFormat
      def function_generate(pFunction)
        # TODO
        return "<function name=\"TODO\">"
      end

      # @see OutputFormat
      def global_variable_generate(pGlobalVariable)
        buildGlobalVariableString = []
        pGlobalVariable.each do |globalVariable|
          buildGlobalVariableString.push("<globalVariable " +
                                          "name=\"#{globalVariable}\" />")
        end
        return buildGlobalVariableString.join("\n")
      end

      # @see OutputFormat
      def extern_requirement_generate(pRequire)
        # TODO: Extern requirement not follows the global behaviour. Fix it.
        buildExternRequirement = []
        pRequire.each do |path|
          buildExternRequirement.push("<require name=\"#{path}\" />")
        end
        return buildExternRequirement.join("\n")
      end

      # @see OutputFormat
      def repetition_generate(pRepetition)
        buildRepetition = []
        # TODO: We have to call it recursively and inspect for conditional too.
        pRepetition.each do |repetition|
          buildRepetition.push("<repetition type=\"#{repetition.type}\" " +
                               "expression=\"#{repetition.expression}\" />")
        end
        return buildRepetition.join("\n")
      end

      # @see OutputFormat
      def module_generate(pModule)
        buildModule = []
        pModule.each do |modules|
          buildModule.push(default_fields("module", pModule))
        end
        return buildModule.join("\n")
      end


      # @see OutputFormat
      def conditional_generate(pConditional)
        buildConditional = []
        buildConditional.each do |conditional|
          buildConditional.push("<conditional type=\"#{conditional}\" " +
                                "expression=\"#{conditional.expression}\" />")
        end
        return buildConditional.join("\n")
      end

    private

      def default_fields(pLabelField, pElement, pCloseIt=true)
        buildString = "<#{pLabelField} name=\"#{pElement.name}\" "
        buildString += "visibility=\"#{pElement.visibility}\""
        buildString += (pElement.comments.empty?) ? " " :
                        "\n\tcomments=\"#{pElement.comments}\" "
        buildString += (pCloseIt) ? "/>" : ">"
        return buildString
      end

  # class
  end

# module
end
