#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

require_relative 'logger'

module Util

  # Handling HTML log.
  class HtmlLogger < Logger

    public

      # @param pPath [String] Receives the path to save the log.
      def initialize(pPath = "/tmp/kuniri_log.html")
        super(pPath)
        initialize_html_file
      end

      # @param pMessage [String] Log message to be write as .html
      # documentation.
      def write_log(pMessage)
        File.open(@log_path, 'a') do |file|
          file.write("<hr>\n")
          file.write("<p>" + Time.now.strftime("%d/%m/%Y %H:%M:%S") + "</p>\n")
          file.write("\t<i>#{pMessage}</i>\n")
        end
      end

    private

      def initialize_html_file
        File.open(@log_path, 'a') do |file|
          file.write("<html>\n")
          file.write("\t<title>Kuniri log</title>\n\n")
          #file.write("<body>\n")
          #file.write("</body>\n")
        end
      end

  # Class
  end

# Util
end
