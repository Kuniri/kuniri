require_relative '../language/language_factory'
require_relative '../util/html_logger'
require_relative '../util/html_logger'

# Module responsible for keeping the parser handler
module Parser

  # Keep the relationship between languages and project
  class Parser

      public

        attr_accessor :language
        attr_reader :fileLanguage

        def initialize(pFilesPath, pLanguage = "ruby")
          @filesPath = pFilesPath
          @fileLanguage = []
          @log = @settings = Kuniri::Setting.create.log
          @factory = Languages::LanguageFactory.new
          @language = pLanguage
        end

        # Start parse in the project.
        def start_parser
          if (@filesPath.empty?)
            @log.write_log("Error: FilePath can not be empty")
            raise Error::ConfigurationFileError
          end

          @log.write_log("Debug: START FIRST PARSER")
          @filesPath.each do |file|
            language = @factory.get_language(@language)
            language.analyse_source(file)
            @fileLanguage.push(language)
          end
        end

      private

        @filesPath
        @log
        @factory

  # class
  end

# module
end
