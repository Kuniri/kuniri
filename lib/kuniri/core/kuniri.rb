require_relative '../error/configuration_file_error'
require_relative '../parser/parser'
require_relative '../util/logger'
require_relative 'configuration/language_available'
require_relative 'configuration/monitor_available'
require_relative 'configuration/log_available'
require_relative 'setting'

# Kuniri module connect all the elements and use it in the proper sequence.
module Kuniri

  # Kuniri class have the reference for all files and settings. Basically this
  # class launch the application.
  class Kuniri

    public

      # @param pPath Receives the path of configuration file. If any element
      #         is given, it tries to find in the current folder.
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

      def get_parser
        @parser
      end

    private

      @configurationInfo # !@attribute Hash with configuration description
      @filesProject      # !@attribute Array with object reference of all files
      @parser            # !@attribute Execute the parser based on settings.
      @parserFiles       # !@attribute Final output from parser.
      @log               # !@attribute Log reference.

      # !@param pPath Relative path of the project.
      # !@param pLanguage Language extension for make the parser.
      def get_project_file(pPath="./", pLanguage="**.rb")
        # Verify if path is a valid directory or file
        return nil unless File.file?(pPath) or File.directory?(pPath)

        # Handle single file
        if (File.file?(pPath))
          @filesProject = [pPath]
        # Handle multiple files
        else
          @filesProject = Dir[File.join(pPath, "**", pLanguage)]
        end

        @log.write_log("Info: Reading all files.")
        return @filesProject
      end

  # Class
  end

# Kuniri
end
