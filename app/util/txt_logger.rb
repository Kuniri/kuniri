require 'date'
require_relative 'logger'

module Util
  # Create log in a txt format.
  class Txt_Logger < Logger

    # @param path [String] Path for save the log. The default is /tmp/
    def initialize(path = "/tmp")
      super(path)
    end

    # Write a message as a txt file.
    # @param message [String] Massage to be write in the log file.
    def write_log(message)
      File.open(@log_path, 'a') do |file|
        file.write("="*10 + "\n")
        file.write("time: " + Time.now.strftime("%d/%m/%Y %H:%M:%S") + "\n")
        file.write("message: " + message + "\n")
      end
    end
  end
end 
