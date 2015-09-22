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
        buildClassString += temporaryStringXML unless temporaryStringXML.empty?
        # 2 - Attributes
        temporaryStringXML = attribute_generate(pClass.attributes)
        buildClassString += temporaryStringXML + "\n" unless temporaryStringXML.empty?
        # 3 - Constructors
        temporaryStringXML = constructor_generate(pClass.constructors)
        buildClassString += temporaryStringXML + "\n" unless temporaryStringXML.empty?
        # 4 - Methods
        temporaryStringXML = method_generate(pClass.methods)
        buildClassString += temporaryStringXML + "\n" unless temporaryStringXML.empty?
        # 5 - TODO: You have to handler class inside class

        # Close class
        buildClassString += "</class>"

        return buildClassString
      end

      # @see OutputFormat
      def constructor_generate(pConstructor)

        return "" if pConstructor.empty?

        # Special case, empty constructor
        if (pConstructor.parameters.empty? &&
            pConstructor.conditionals.empty? &&
            pConstructor.repetitions.empty?)
            return default_fields("constructor", pConstructor)
        end

        buildConstructorStringXML = ""
        buildConstructorStringXML += default_fields("constructor",
                                                    pConstructor, false)

        # 1 - Handle parameters
        temporaryStringXML = parameters_generate(pConstructor)
        buildConstructorStringXML += temporaryStringXML unless temporaryStringXML
        # 2 - Conditional
        temporaryStringXML = conditional_generate(pConstructor)
        buildConstructorStringXML += temporaryStringXML unless temporaryStringXML
        # 3 - Repetition
        buildConstructorStringXML += temporaryStringXML unless temporaryStringXML
        # 4 - TODO: local variable

        buildConstructorStringXML += "\n</constructor>"
        return buildConstructorStringXML

      end

      # @see OutputFormat
      def inheritance_generate(pInheritances)

        return "" if pInheritances.empty?

        inheritanceString = []
        pInheritances.each do |inheritance|
          inheritanceString.push("<inheritance name=\"#{inheritance}\" />")
        end

        return inheritanceString.join("\n")
      end

      # @see OutputFormat
      def method_generate(pMethod)

        return "" if pMethod.empty?

        temporaryStringXML = ""
        buildMethodStringXML = ""

        pMethod.each do |method|
          # Empty method
          if (method.parameters.empty? && method.conditionals.empty? &&
              method.repetitions.empty?)
              buildMethodStringXML += default_fields("method", method)
              next
          end

          temporaryStringXML += default_fields("method", method, false)

          # 1 - Handle parameters
          temporaryStringXML = parameters_generate(method.parameters)
          buildMethodStringXML += temporaryStringXML unless temporaryStringXML
          # 2 - Conditional
          temporaryStringXML = conditional_generate(method)
          buildMethodStringXML += temporaryStringXML unless temporaryStringXML
          # 3 - Repetition
          buildMethodStringXML += temporaryStringXML unless temporaryStringXML
          # 4 - TODO: local variable

          buildMethodStringXML += "\n</method>"
        end

        return buildMethodStringXML
      end

      # @see OutputFormat
      def parameters_generate(pParameters)

        return "" if pParameters.empty?

        buildParameterString = []
        pParameters.each do |parameter|
           buildParameterString.push("<parameter name=\"#{parameter}\">")
        end

        return buildParameterString.join("\n")
      end

      # @see OutputFormat
      def attribute_generate(pAttribute)

        return "" if pAttribute.empty?

        buildAttributeString = []
        pAttribute.each do |attribute|
          buildAttributeString.push("<attribute name=\"#{attribute.name}\" />")
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

        return "" if pGlobalVariable.empty?

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

        return "" if pRequire.empty?

        buildExternRequirement = []
        pRequire.each do |path|
          buildExternRequirement.push("<require name=\"#{path}\" />")
        end

        return buildExternRequirement.join("\n")
      end

      # @see OutputFormat
      def repetition_generate(pRepetition)

        return "" if pRepetition.empty?

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

        return "" if pModule.empty?

        buildModule = []
        pModule.each do |modules|
          buildModule.push(default_fields("module", pModule))
        end
        return buildModule.join("\n")
      end


      # @see OutputFormat
      def conditional_generate(pConditional)

        return "" if pConditional.empty?

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
        return buildString + "\n"
      end

      def handle_function_behavior

        return "" if pMethod.empty?

        # Empty method
        if (pMethod.parameters.empty? && pMethod.conditionals.empty? &&
            pMethod.repetitions.empty?)
            return default_fields("method", pMethod)
        end

        default_fields("method", pMethod, false)

        #send(#{begin}_generate(element))
        # 1 - Handle parameters
        temporaryStringXML = parameters_generate(pConstructor.parameters)
        buildConstructorStringXML += temporaryStringXML unless temporaryStringXML
        # 2 - Conditional
        temporaryStringXML = conditional_generate(pConstructor)
        buildConstructorStringXML += temporaryStringXML unless temporaryStringXML
        # 3 - Repetition
        buildConstructorStringXML += temporaryStringXML unless temporaryStringXML
        # 4 - TODO: local variable

        buildConstructorStringXML += "\n</method>"
        return buildConstructorStringXML

      end

  # class
  end

# module
end
