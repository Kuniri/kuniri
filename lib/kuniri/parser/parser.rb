#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

require_relative '../language/language_factory'

# Module responsible for keeping the parser handler
module Parser

  # Keep the relationship between languages and project
  class Parser

      public

        attr_accessor :language
        attr_reader :fileLanguage
        attr_reader :filesPath

        def initialize(pFilesPath, pLanguage = "ruby")
          @filesPath = pFilesPath
          @fileLanguage = []
          @factory = Languages::LanguageFactory.new
          @language = pLanguage
        end

        # Start parse in the project.
        def start_parser
          raise Error::ConfigurationFileError,
            "Source path not have #{@language} files." if(@filesPath.empty?)
          @filesPath.each do |file|
            language = @factory.get_language(@language)
            language.analyse_source(file)
            @fileLanguage.push(language)
          end
        end

      private

        @factory

  # class
  end

# module
end
