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

      wrapper = self
      # Go through each file
      pParser.fileLanguage.each do |listOfFile|
        # Inspect each element
        listOfFile.fileElements.each do |singleElement|
          @outputEngine.kuniri do
            wrapper.handle_element(singleElement)
          end
          currentFilePathAndName = singleElement.name
          write_file(currentFilePathAndName)
          @outputEngine.reset_engine
        end
      end
    end

    def handle_element(singleElement)
      handle_extern_requirements(singleElement)
      handle_modules(singleElement)
      handle_global_variables(singleElement)
      handle_cond_loop_and_block(singleElement)
      handle_global_functions(singleElement)
      handle_classes(singleElement)
    end

    def handle_extern_requirements(singleElement)
      reqs = singleElement.extern_requirements
      len = reqs.length
      extern_requirement_generate(reqs) if len.positive?
    end

    def handle_modules(singleElement)
      modules = singleElement.modules
      len = modules.length
      module_generate(modules) if len.positive?
    end

    def handle_global_variables(singleElement)
      vars = singleElement.global_variables
      len = vars.length
      global_variable_generate(vars) if len.positive?
    end

    def handle_cond_loop_and_block(singleElement)
      basic_struct = singleElement.managerCondLoopAndBlock.basicStructure
      len = basic_struct.length
      basic_structure_generate(basic_struct) if len.positive?
    end

    def handle_global_functions(singleElement)
      funcs = singleElement.global_functions
      len = funcs.length
      generate_global_functions(funcs) if len.positive?
    end

    def generate_global_functions(global_functions)
      global_functions.each do |globalFunction|
        function_behaviour_generate('functionData',
                                    globalFunction)
      end
    end

    def handle_classes(singleElement)
      classes = singleElement.classes
      length = classes.length
      class_generate(classes) if length.positive?
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

    def write_file(pFileNameAndPath)
      info = Kuniri::Setting.create
      fileName = File.basename(pFileNameAndPath, '.*')
      if !File.file?(info.configurationInfo[:source])
        outputDir = File.join(@parserPath, File.dirname(pFileNameAndPath))
        unless Dir.exist? outputDir
          FileUtils.mkdir_p(File.join(@parserPath,
                                      File.dirname(pFileNameAndPath)))
        end
        # TODO: Extension should be flexible
        destination = File.join(outputDir, fileName + '.xml')
      else
        destination = @parserPath
      end

      File.open(destination, 'w') do |file|
        file.write(@outputEngine.to_xml)
      end
    end
  end # class
end # module
