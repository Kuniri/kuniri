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
    
  end

end
