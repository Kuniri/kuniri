# Util provides classes, functions and constants which can be used for the 
# entire system.
module Util
  # Abstract class responsible for define the log strategy. 
  class Logger
    def initialize(path = "/tmp")
      File.open(path, 'a')
      @log_path = path 
    end

    public
      # Write log, based on the message and the path
      # @override 
      def write_log(message); NotImplementedError end
    protected
      @log_path
  end 
end
