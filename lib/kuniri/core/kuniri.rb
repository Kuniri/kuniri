require_relative '../error/configuration_file_error'
require_relative 'language/language_available'
require_relative 'monitor/monitor_available'

# Kuniri is the main class of the system, responsible for handling: monitoring 
# style, language type, and Settings.
module Kuniri

  class Kuniri

    public

      # Read the configuration file and return a list with the configurations.
      # In this method it is checked the configuration file syntax.
      # @param path [String] Path to ".kuniri" file, it means, the 
      #         configurations.
      # @return [Hash] Return a Hash with the configurations read in ".kuniri",
      #     otherwise, raise an exception.
      # @raise [type] Raise an syntax error if ".kuniri" has any syntax mistake
      # @raise [type] Raised in the case of the path is wrong.
      def read_configuration_file(path = "./kuniri")
        raise Error::ConfigurationFileError unless File.exists?(path)

        configuration = Hash.new
        File.open(path).each_line do |line|
          parts = line.split(':').size
          raise Error::ConfigurationFileError unless (parts == 2)
          key = handling_basic_syntax(line, 0)
          value = handling_basic_syntax(line, 1)
          configuration[key] = value
        end

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

        return configuration
      end

    private

      def validate_field(configuration_hash, key)
        if configuration_hash.has_key?(key)
          value = configuration_hash[key]
          value.split(',').each do |element|
            raise Error::ConfigurationFileError unless yield(element)
          end
        end
      end

      def handling_basic_syntax(line, index)
        text = line.split(':')[index].downcase
        text.gsub!(/\s/, '')
        return text
      end

  # Class
  end

# Kuniri
end
