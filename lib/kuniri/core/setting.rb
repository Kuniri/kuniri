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

      def initializate_settings(pFilePath = ".kuniri")
        begin
          @configurationInfo = read_configuration_file(pFilePath)
          initialize_object
        rescue Error::ConfigurationFileError
          puts "You have a syntax problem on your configuration file."
          abort
        end

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
          # @log.write_log("Info: Not provide configuration file. Get default")
          configuration = default_configuration
        else
          configuration = parser_configuration_file(pPath)
        end

        # @log.write_log("First reading configuration file: #{configuration}")

        validate_field(configuration, "language") do |language|
          Configuration::Language_Available::LANGUAGES.include?(language)
        end

        validate_field(configuration, "source") do |sourcePath|
          File.exists?(sourcePath)
        end

        validate_field(configuration, "output") do |outputPath|
          File.exists?(outputPath)
        end

        validate_field(configuration, "extract") do |extract|
          Configuration::Monitor_Available::MONITORS.include?(extract.downcase)
        end

        validate_field(configuration, "log") do |log|
          Configuration::Log_Available::LOG.include?(log.downcase)
        end

        # @log.write_log("Debug: Configuration: #{configuration}")

        return configuration
      end

    private

      @@settings = nil

      def default_configuration
        configuration = {"language" => "ruby",
                          "source" => "./",
                          "output" => "./",
                          "extract" => "uml",
                          "log" => "html"}
        return configuration
      end

      def parser_configuration_file(pPath)
        configuration = default_configuration

        # @log.write_log("Debug: Reading cofiguration file in: #{pPath}")
        File.open(pPath, mode="r").each_line do |line|
          parts = line.split(':').size
          unless (parts == 2)
            # @log.write_log("Syntax error on configuration file.")
            raise Error::ConfigurationFileError
          end
          key = handling_basic_syntax(line, 0)
          value = handling_basic_syntax(line, 1)
          configuration[key] = value
        end
        return configuration
      end

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

      def initialize_object
        logType = @configurationInfo["log"]
        if logType == "html"
          @log = Util::HtmlLogger.new
        elsif logType == "txt"
          @log = Util::TxtLogger.new
        end
      end

  # Class
  end

# Module
end
