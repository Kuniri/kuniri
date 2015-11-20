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
          raise Error::ConfigurationFileError if(@filesPath.empty?)

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
