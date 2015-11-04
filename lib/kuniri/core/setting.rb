require 'yaml'
require_relative 'configuration/language_available'
require_relative 'configuration/monitor_available'
require_relative 'configuration/log_available'

require_relative '../util/html_logger'
require_relative '../util/txt_logger'
require_relative '../error/configuration_file_error'

module Kuniri

  # Class Setting that read and handling .kuniri file.
  class Setting

    public

      private_class_method :new
      attr_reader :configurationInfo
      attr_reader :log

      def initialize
        initializate_settings
      end

      def Setting.create
        @@settings = new unless @@settings
        return @@settings
      end

      def initializate_settings(pFilePath = ".kuniri.yml")
        begin
          @configurationInfo = read_configuration_file(pFilePath)
          initialize_object
        rescue Error::ConfigurationFileError
          puts "You have a syntax problem on your configuration file."
          abort
        end
      end

      # In this method it is checked the configuration file syntax.
      # @param pPath [String] Path to ".kuniri" file, it means, the
      #         configurations.
      # @return [Hash] Return a Hash with the configurations read in ".kuniri",
      #     otherwise, raise an exception.
      # @raise [type] Raise an syntax error if ".kuniri" has any syntax mistake
      # @raise [type] Raised in the case of the path is wrong.
      def read_configuration_file(pPath = ".kuniri.yml")

        unless File.exists?(pPath)
          # @log.write_log("Info: Not provide configuration file. Get default")
          configuration = default_configuration
          return configuration
        end
        @configurationInfo = YAML.load(File.read(pPath))

        return @configurationInfo
      end

    private

      @@settings = nil

      def default_configuration
        configuration = {:language => "ruby",
                         :source => "./",
                         :output => "./",
                         :extract => "uml",
                         :log => "html"}
        return configuration
      end

      def initialize_object
        logType = @configurationInfo["log"]
        if logType == "html"
          @log = Util::HtmlLogger.new
        elsif logType == "txt"
          @log = Util::TxtLogger.new
        else
          @log = Util::HtmlLogger.new
        end
      end

  # Class
  end

# Module
end
