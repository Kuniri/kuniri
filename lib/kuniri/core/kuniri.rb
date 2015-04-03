require_relative '../error/configuration_file_error'
require_relative '../parser/parser'
require_relative '../util/logger'
require_relative '../navigate/code_navigate'
require_relative 'configuration/language_available'
require_relative 'configuration/monitor_available'
require_relative 'configuration/log_available'
require_relative 'setting'

# Kuniri is the main class of the system, responsible for handling: monitoring 
# style, language type, and Settings.
module Kuniri

  class Kuniri

    public

      def initialize(pPath = ".kuniri")
        @configurationInfo = {}
        @filesPathProject = []
        @parserFiles = []
        @parser = nil

        @settings = Setting.create
        @settings.initializate_settings(pPath)
        @log = @settings.log
        @configurationInfo = @settings.configurationInfo

        @log.write_log("info: Kuniri object successfully created.")
      end

      # Start Kuniri tasks based on configuration file. After read 
      # configuration file, find all files in source directory.
      # @param pPath [String] Path of configuration file. Default is the 
      #         current directory
      def run_analysis()
        @log.write_log("info: Start to run analysis.")
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

      def start_navigation_mode
        unless @parser
          puts "Please, run parse first :("
          return -1
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

      def get_project_file(pPath="./", pLanguage="**.rb")
        return nil unless File.exists?(pPath)

        @log.write_log("Info: Reading all files.")

        @filesProject = Dir[File.join(pPath, "**", pLanguage)]
      end

  # Class
  end

# Kuniri
end
