module Parser

  class OutputFormat

    public

      def create_data(pParser)
        # @log.write_log("Start parser: create data")

        # Go through each file
        pParser.fileLanguage.each do |listOfFile|

          # Inspect each element
          listOfFile.fileElements.each do |singleElement|

            if (singleElement.classes.length() > 0)
              class_generate(singleElement.classes)
            elsif (singleElement.global_functions.length() > 0)
              function_generate(singleElement.global_functions)
            elsif (singleElement.global_variables.length() > 0)
              global_variable_generate(singleElement.global_variables)
            elsif (singleElement.extern_requirements.length() > 0)
              extern_requirement_generate(singleElement.extern_requirements)
            elsif (singleElement.modules.length() > 0)
              module_generate(singleElement.modules)
            end

          end
        end
      end

      def class_generate(pClass)
        raise NotImplementedError
      end

      def constructor_generate(pConstructor)
        raise NotImplementedError
      end

      def inheritance_generate(pInheritance)
        raise NotImplementedError
      end

      def method_generate(pMethod)
        raise NotImplementedError
      end

      def parameters_generate(pParameters)
        raise NotImplementedError
      end

      def attribute_generate(pAttribute)
        raise NotImplementedError
      end

      def function_generate(pFunction)
        raise NotImplementedError
      end

      def global_variable_generate(pGlobalVariable)
        raise NotImplementedError
      end

      def extern_requirement_generate(pRequire)
        raise NotImplementedError
      end

      def repetition_generate(pRepetition)
        raise NotImplementedError
      end

      def module_generate(pModule)
        raise NotImplementedError
      end

      def conditional_generate(pConditional)
        raise NotImplementedError
      end

  # class
  end

# module
end
