module Parser

  class OutputFormat

    public

      attr_accessor :outputEngine
      attr_accessor :parserPath
      attr_accessor :extension

      # Set path to save the output.
      # @param pPath Output path.
      def set_path(pPath)
        @parserPath = pPath
      end

      def create_all_data(pParser)
        wrapper = self
        # Go through each file
        pParser.fileLanguage.each do |listOfFile|
          # Inspect each element
          listOfFile.fileElements.each do |singleElement|
            @outputEngine.kuniri do
              if (singleElement.extern_requirements.length() > 0)
                wrapper.extern_requirement_generate(singleElement.extern_requirements)
              end
              if (singleElement.modules.length() > 0)
                wrapper.module_generate(singleElement.modules)
              end
              if (singleElement.global_variables.length() > 0)
                wrapper.global_variable_generate(singleElement.global_variables)
              end
              if (singleElement.global_functions.length() > 0)
                wrapper.function_generate(singleElement.global_functions)
              end
              if (singleElement.classes.length() > 0)
                wrapper.class_generate(singleElement.classes)
              end
            end
          end

          # TODO: save the current output, or mix everything in the same file.
          # DOIT here!
          File.open("test_out/" + listOfFile.name + ".xml", 'w') do |file|
           file.write(@outputEngine.to_xml)
          end
          @outputEngine.reset_engine
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

      def comment_generate(pComment)
        raise NotImplementedError
      end

  # class
  end

# module
end
