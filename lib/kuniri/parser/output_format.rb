#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

require 'fileutils'

require_relative '../core/setting'

module Parser

  class OutputFormat
    attr_accessor :outputEngine
    attr_accessor :parserPath
    attr_accessor :extension
    attr_reader :optimizationLevel

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

      saveElementTo = './'
      wrapper = self

      # Go through each file
      pParser.fileLanguage.each do |listOfFile|
        # Inspect each element
        listOfFile.fileElements.each do |singleElement|
          @outputEngine.kuniri do
            if (singleElement.extern_requirements.length.positive?)
              wrapper.extern_requirement_generate(
                singleElement.extern_requirements
              )
            end
            if (singleElement.modules.length.positive?)
              wrapper.module_generate(singleElement.modules)
            end
            if (singleElement.global_variables.length.positive?)
              wrapper.global_variable_generate(
                singleElement.global_variables
              )
            end
            unless singleElement.managerCondLoopAndBlock.basicStructure.empty?
              wrapper.basic_structure_generate(
                singleElement.managerCondLoopAndBlock.basicStructure
              )
            end
            if (singleElement.global_functions.length.positive?)
              singleElement.global_functions.each do |globalFunction|
                wrapper.function_behaviour_generate('functionData',
                                                    globalFunction)
              end
            end
            if (singleElement.classes.length.positive?)
              wrapper.class_generate(singleElement.classes)
            end
          end
          saveElementTo = singleElement.name
        end

        write_file(saveElementTo, listOfFile.name)
        @outputEngine.reset_engine
      end
    end

    def class_generate(_pClass)
      raise NotImplementedError
    end

    def inheritance_generate(_pInheritance)
      raise NotImplementedError
    end

    def parameters_generate(_pParameters)
      raise NotImplementedError
    end

    def attribute_generate(_pAttribute)
      raise NotImplementedError
    end

    def function_behaviour_generate(_pElementName, _pFunction)
      raise NotImplementedError
    end

    def global_variable_generate(_pGlobalVariable)
      raise NotImplementedError
    end

    def extern_requirement_generate(_pRequire)
      raise NotImplementedError
    end

    def basic_structure_generate(_pManager)
      raise NotImplementedError
    end

    def module_generate(_pModule)
      raise NotImplementedError
    end

    def comment_generate(_pComment)
      raise NotImplementedError
    end

    def aggregation_generate(_pAggregation)
      raise NotImplementedError
    end

    def conditional_generate(_pConditional)
      raise NotImplementedError
    end

    def repetition_generate(_pRepetition)
      raise NotImplementedError
    end

    private

    def write_file(pSaveTo, pFileName)
      info = Kuniri::Setting.create
      if !File.file?(info.configurationInfo[:source])
        outputDir = File.join(@parserPath, File.dirname(pSaveTo))
        unless Dir.exist? outputDir
          FileUtils.mkdir_p(File.join(@parserPath,
                                      File.dirname(pSaveTo)))
        end
        # TODO: Extension should be flexible
        destination = File.join(outputDir, pFileName + '.xml')
      else
        destination = @parserPath
      end

      File.open(destination, 'w') do |file|
        file.write(@outputEngine.to_xml)
      end
    end
  end # class
end # module
