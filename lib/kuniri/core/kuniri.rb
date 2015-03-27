require_relative '../error/configuration_file_error'
require_relative '../parser/parser'
require_relative '../util/logger'
require_relative '../navigate/code_navigate'
require_relative 'language/language_available'
require_relative 'monitor/monitor_available'

# Kuniri is the main class of the system, responsible for handling: monitoring 
# style, language type, and Settings.
module Kuniri

  class Kuniri

    public

      def initialize
        @configurationInfo = {}
        @filesPathProject = []
        @parserFiles = []
        @parser = nil
        # TODO: create factory for build object
        @log = Util::HtmlLogger.new
        @log.write_log("info: Kuniri object successfully created.")
      end

      # Start Kuniri tasks based on configuration file. After read 
      # configuration file, find all files in source directory.
      # @param pPath [String] Path of configuration file. Default is the 
      #         current directory
      def run_analysis(pPath = ".kuniri")
        @log.write_log("info: Start to run analysis.")
        @configurationInfo = read_configuration_file(pPath)

        @log.write_log("debug: ConfigurationInfo: #{@configurationInfo}")
        @filesPathProject = get_project_file(@configurationInfo["source"])
        unless @filesPathProject
          puts "Problem on source path: #{@configurationInfo["source"]}"
          @log.write_log("Prolblem when tried to access source folder.")
          return -1
        end

        @log.write_log("debug: files: #{@filesPathProject.to_s}")
        @parser = Parser::Parser.new(@filesPathProject)
        @parser.start_parser()
      end

      # Read the configuration file and return a list with the configurations.
      # In this method it is checked the configuration file syntax.
      # @param path [String] Path to ".kuniri" file, it means, the 
      #         configurations.
      # @return [Hash] Return a Hash with the configurations read in ".kuniri",
      #     otherwise, raise an exception.
      # @raise [type] Raise an syntax error if ".kuniri" has any syntax mistake
      # @raise [type] Raised in the case of the path is wrong.
      def read_configuration_file(pPath = ".kuniri")
        configuration = {}

        unless File.exists?(pPath)
          @log.write_log("Info: Not provide configuration file. Get default")
          configuration = default_configuration
        else
          configuration = parser_configuration_file(pPath)
        end

        @log.write_log("First reading configuration file: #{configuration}")

        validate_field(configuration, "language") do |language|
          Configuration::Language_Available::LANGUAGES.include?(language)
        end

        validate_field(configuration, "source"){|sourcePath|
          File.exists?(sourcePath)}

        validate_field(configuration, "output"){|outputPath|
          File.exists?(outputPath)}

        validate_field(configuration, "extract"){|extract|
          Configuration::Monitor_Available::MONITORS.include?(
            extract.downcase)}

        @log.write_log("Debug: Configuration: #{configuration}")

        return configuration
      end

      def default_configuration
        configuration = {"language" => "ruby",
                          "source" => "./",
                          "output" => "bin/",
                          "extract" => "uml"}
        return configuration
      end

      def parser_configuration_file(pPath)
        configuration = {}

        @log.write_log("Debug: Reading cofiguration file in: #{pPath}")
        File.open(pPath, mode="r").each_line do |line|
          parts = line.split(':').size
          unless (parts == 2)
            puts "Syntax error, please verify your configuration file"
            puts "Syntax error: #{line}"
            @log.write_log("Syntax error on configuration file.")
            abort
          end
          key = handling_basic_syntax(line, 0)
          value = handling_basic_syntax(line, 1)
          configuration[key] = value
        end
        return configuration
      end

      def start_navigation_mode
        unless @parser
          puts "Please, run parse first :("
          return
        end
        files = @parser.fileLanguage 
        navigate = Navigate::CodeNavigate.new(files)
        navigate.navigate_mode
      end

    private

      @configurationInfo
      @filesProject
      @parser
      @parserFiles
      @log

      def validate_field(pConfiguration_hash, pKey)
        if pConfiguration_hash.has_key?(pKey)
          value = pConfiguration_hash[pKey]
          value.split(',').each do |element|
            raise Error::ConfigurationFileError unless yield(element)
          end
        end
      end

      def handling_basic_syntax(pLine, pIndex)
        text = pLine.split(':')[pIndex].downcase
        text.gsub!(/\s/, '')
        return text
      end

      def get_project_file(pPath="./", pLanguage="**.rb")
        return nil unless File.exists?(pPath)

        @log.write_log("Info: Reading all files.")

        @filesProject = Dir[File.join(pPath, "**", pLanguage)]
      end

  # Class
  end

# Kuniri
end
