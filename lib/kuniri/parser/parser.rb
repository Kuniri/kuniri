require_relative '../language/ruby/ruby_syntax'
require_relative '../util/html_logger'

# Module responsible for keeping the parser handler
module Parser

  # Keep the relationship between languages and project
  class Parser
  #TODO: CREATE FACTORY
      public

        attr_accessor :language

        def initialize(pFilesPath)
          @filesPath = pFilesPath
          @fileLanguage = []
          @log = Util::HtmlLogger.new
        end

        def start_parser
          # TODO: handle the case of filePAth is empty
          @log.write_log("Debug: START FIRST PARSER")
          @filesPath.each do |file|
            # TODO: Do not create object in this way, use factory.
            language = Languages::RubySyntax.new
            language.analyse_source(file)
            @fileLanguage.push(language)
          end
        end

        def get_object_files
          return @fileLanguage
        end

      private

        @filesPath
        @fileLanguage
        @log

  # class
  end

# module
end
