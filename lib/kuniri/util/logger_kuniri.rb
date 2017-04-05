#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details
require 'logger'
#require 'byebug'

# Util provides classes, functions and constants which can be used for the
# entire system.
module Util

  # Abstract class responsible for define the log.
  class LoggerKuniri

    private_class_method :new
    @@logger = nil
    @@path = nil

    # It is desirable to have a single instance of log for the entire system
    # because of this only the class is responsible to control the object
    # creation
    # @return logger reference
    def self.create(pOutput)
      #    def self.create(pOutput=STDOUT)
      unless @@logger
        @@logger = Logger.new(pOutput)
        @@logger.level = Logger::WARN
      end
      return @@logger
    end

    def self.path=(path)
      @@path = path
    end


    # With this method, we can handle all kind of log level available by ruby
    # E.g: Util::LoggerKuniri.info('lalala')
    def self.method_missing(pLogPrint, *pLogMessage)
      self.create(@@path)
      @@logger.send(pLogPrint, pLogMessage.join(''))
    end

    # Change log output
    def self.update_log_output(pOutput)
      @@logger = nil
      @@logger = create(pOutput)
    end

    # Update log level
    def self.update_log_level(pLevel)
      self.create(@@path)
      @@logger.level = pLevel
    end

  # Class
  end
# Util
end
