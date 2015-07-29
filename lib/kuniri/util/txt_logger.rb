require 'date'
require_relative 'logger'

module Util

  # Create log in a text format. This classes handling the correct way of
  # generate the log in a .txt format.
  class TxtLogger < Util::Logger

    # @param pPath [String] Path for save the log. The default is /tmp/
    def initialize(pPath = "/tmp/kuniri.log")
      super(pPath)
    end

    # Write a message as .txt file.
    # @param pMessage [String] Massage to be write in the log file.
    def write_log(pMessage)
      File.open(@log_path, 'a') do |file|
        file.write("="*10 + "\n")
        file.write("time: " + Time.now.strftime("%d/%m/%Y %H:%M:%S") + "\n")
        file.write("message: " + pMessage + "\n")
      end
    end

  # Class
  end

# Util
end 
