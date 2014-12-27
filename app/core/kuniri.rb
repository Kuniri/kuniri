require_relative '../../config/language/LanguageAvailable.rb'

# Kuniri is the main class of the system, responsible for handling: monitoring 
# style, language type, and Settings. 
class Kuniri

  # Read the configuration file and return a list with the configurations. In 
  # this method it is checked the configuration file syntax.
  # @param path [String] Path to ".kuniri" file, it means, the configurations.
  # @return [Hash] Return a Hash with the configurations read in ".kuniri", 
  #     othewise, raise an exception.
  # @raise [type] Raise an syntax error if ".kuniri" has any syntax mistake.
  # @raise [type] Raised in the case of the path is wrong.
  def read_configuration_file(path = "./kuniri")
    
    unless File.exists?(path)
      raise Error::Configuration_file_error
    end

    configuration = Hash.new
    
    File.open(path).each_line do |line|
      parts = line.split(':').size
      raise Error::Configuration_file_error unless (parts == 2)
      #Handling string: downcase and remove white space
      key = line.split(':')[0].downcase
      key.gsub!(/\s/, '')
      value = line.split(':')[1].downcase
      value.gsub!(/\s/, '')
      configuration[key] = value
    end

    if configuration.has_key?("language")
      language = configuration["language"]
      unless Configuration::LanguageAvailable::LANGUAGES.include?(language)
        raise Error::Configuration_file_error
      end
    end

    return configuration

  end

end
