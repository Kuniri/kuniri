require_relative 'logger'

module Util
  # Handling HTML log. 
  class HtmlLogger < Logger

    # @param path [String] Receives the path to save the log.
    def initialize(path = "/tmp")
      super(path)
    end

    # @param message [String] Log message to be write as .html documentation.
    def write_log(message)
      File.open(@log_path, 'a') do |file|
        file.write("<p>" + Time.now.strftime("%d/%m/%Y %H:%M:%S") + "</p>\n")
        file.write("       <i>HTML log</i>\n")
      end
    end
  end
end
