# Util provides classes, functions and constants which can be used for the
# entire system.
module Util

  # Abstract class responsible for define the log strategy.
  class Logger

    # Create/open the log file, and save the path.
    # @param path [String] Receives the path for save the log file. By default
    #   it is saved on /tmp with the name "kuniri".
    def initialize(pPath = "/tmp/kuniri.log")
      File.open(pPath, 'a')
      @log_path = pPath
    end

    public

      # Write log, based on the message and the path. The most important thing
      # about this method, is related with the implementation in different
      # formats. Ex.: write_log can be implemented as HTML, txt, XML, etc.
      # @param message to write in the log file.
      def write_log(pMessage)
        raise NotImplementedError
      end

    protected

      @log_path # Saved path of the log file.

  # Class
  end

# Util
end
