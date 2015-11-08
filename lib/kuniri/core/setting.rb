require 'yaml'
require_relative 'configuration/language_available'
require_relative '../error/configuration_file_error'

module Kuniri

  # Class Setting that read and handling .kuniri file.
  class Setting

    public

      private_class_method :new
      attr_reader :configurationInfo

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
      def read_configuration_file(pPath = ".kuniri.yml")

        unless File.exists?(pPath)
          set_default_configuration
        else
          @configurationInfo = YAML.load(File.read(pPath))
          verify_syntax
        end

        return @configurationInfo
      end

      def set_configuration(pSource, pLanguage, pOutput, pLevel)
        @configurationInfo[:source] = pSource
        @configurationInfo[:language] = pLanguage
        @configurationInfo[:output] = pOutput
        @configurationInfo[:level] = pLevel
        return @configurationInfo
      end

    private

      @@settings = nil

      def set_default_configuration
        @configurationInfo = {:language => "ruby",
                               :source => "./",
                               :output => "./"}
      end

      def verify_syntax
        unless @configurationInfo.is_a? Hash
          raise Error::ConfigurationFileError
        end

        check_source
        check_output
        check_language
      end

      def check_source
        unless @configurationInfo.has_key?:source
          raise Error::ConfigurationFileError
        else
          source = @configurationInfo[:source]
          result = (File.directory?source) || (File.exists?source)
          unless result
            raise Error::ConfigurationFileError
          end
        end
      end

      def check_output
        unless @configurationInfo.has_key?:output
          raise Error::ConfigurationFileError
        end
      end

      def check_language
        unless @configurationInfo.has_key?:language
          raise Error::ConfigurationFileError
        else
          result = Configuration::LanguageAvailable::LANGUAGES.include?(
                                                @configurationInfo[:language])
          unless result
            raise Error::ConfigurationFileError
          end
        end
      end

  # Class
  end

# Module
end
