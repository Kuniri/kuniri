require_relative 'logger'

module Util
  class Html_Logger < Logger
    def initialize(path)
      super(path)
    end

    def write_log(message)
      File.open(@log_path, 'a') do |file|
        file.write("<p>" + Time.now.strftime("%d/%m/%Y %H:%M:%S") + "</p>\n")
        file.write("       <i>HTML log</i>\n")
      end
    end    
  end
end
