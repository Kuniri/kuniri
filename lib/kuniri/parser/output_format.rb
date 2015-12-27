require 'fileutils'

require_relative '../core/setting'

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

      # Go through all the data, and generate the output
      # @param pParser
      # @return
      def create_all_data(pParser)
        return nil unless pParser

        saveElementTo = "./"
        wrapper = self

        # Go through each file
        pParser.fileLanguage.each do |listOfFile|
          # Inspect each element
          listOfFile.fileElements.each do |singleElement|
            @outputEngine.kuniri do
              if (singleElement.extern_requirements.length() > 0)
                wrapper.extern_requirement_generate(
                        singleElement.extern_requirements)
              end
              if (singleElement.modules.length() > 0)
                wrapper.module_generate(singleElement.modules)
              end
              #if (singleElement.global_variables.length() > 0)
              #  wrapper.global_variable_generate(
              #          singleElement.global_variables)
              #end
              if (singleElement.global_functions.length() > 0)
                singleElement.global_functions.each do |globalFunction|
                  wrapper.function_behaviour_generate("functionData",
                                                      globalFunction)
                end
              end
              if (singleElement.classes.length() > 0)
                wrapper.class_generate(singleElement.classes)
              end
            end
            saveElementTo = singleElement.name
          end

          write_file(saveElementTo, listOfFile.name)
          @outputEngine.reset_engine
        end

      end

      def class_generate(pClass)
        raise NotImplementedError
      end

      def inheritance_generate(pInheritance)
        raise NotImplementedError
      end

      def parameters_generate(pParameters)
        raise NotImplementedError
      end

      def attribute_generate(pAttribute)
        raise NotImplementedError
      end

      def function_behaviour_generate(pElementName, pFunction)
        raise NotImplementedError
      end

      def global_variable_generate(pGlobalVariable)
        raise NotImplementedError
      end

      def extern_requirement_generate(pRequire)
        raise NotImplementedError
      end

      def basic_structure_generate(pManager)
        raise NotImplementedError
      end

      def module_generate(pModule)
        raise NotImplementedError
      end

      def comment_generate(pComment)
        raise NotImplementedError
      end

      def aggregation_generate(pAggregation)
        raise NotImplementedError
      end

    private

      def write_file(pSaveTo, pFileName)
        info = Kuniri::Setting.create
        unless File.file?(info.configurationInfo[:source])
          outputDir = File.join(@parserPath, File.dirname(pSaveTo))
          unless Dir.exists? outputDir
            FileUtils.mkdir_p(File.join(@parserPath,
                                        File.dirname(pSaveTo)))
          end
          # TODO: Extension should be flexible
          destination = File.join(outputDir, pFileName + ".xml")
        else
          destination = @parserPath
        end

        File.open(destination, "w") do |file|
          file.write(@outputEngine.to_xml)
        end
      end

  # class
  end

# module
end
