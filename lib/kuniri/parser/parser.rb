#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

require_relative '../language/language_factory'

# Module responsible for keeping the parser handler
module Parser

  OPTIMIZE_OUTPUT_MAP = {
    'kuniri': 'kr',
    'classData': 'cl',
    'constructorData': 'cn',
    'methodData': 'mt',
    'attributeData': 'at',
    'inheritanceData': 'ih',
    'aggregationData': 'ag',
    'externRequirementData': 'et',
    'moduleData': 'mo',
    'commentData': 'cm',
    'parameterData': 'pr',
    'globalVariableData': 'gl',
    'visibility': 'v',
    'name': 'n',
    'expression': 'e',
    'level': 'l',
    'totalGlobalFunctions': 'tgf'
    'totalMethods': 'tm',
    'totalClasses': 'tc',
    'linesOfCode': 'loc'
  }.freeze

  # Keep the relationship between languages and project
  class Parser
    attr_accessor :language
    attr_reader :fileLanguage
    attr_reader :filesPath

    def initialize(pFilesPath, pLanguage = 'ruby')
      @filesPath = pFilesPath
      @fileLanguage = []
      @factory = Languages::LanguageFactory.new
      @language = pLanguage
    end

    # Start parse in the project.
    def start_parser
      if (@filesPath.empty?)
        raise Error::ConfigurationFileError,
              "Source path not have #{@language} files."
      end
      @filesPath.each do |file|
        language = @factory.get_language(@language)

        fileElement = Languages::FileElementData.new(file)
        source = File.open(file, 'rb')

        language.analyse_source(fileElement, source)
        @fileLanguage.push(language)
      end
    end
  end # class
end # module
