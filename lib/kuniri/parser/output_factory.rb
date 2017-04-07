#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

require_relative '../error/language_error'
require_relative 'xml_output_format'

module Parser

  # Simple factory to create output objects.
  class OutputFactory
    # Handling the output tyoe.
    # @param pType [String] Type of object
    # @return Return an object of output.
    def get_output(pType)
      pType.downcase!

      return XMLOutputFormat.new if pType == 'xml'
      raise Error::ParserError if pType == 'yml'
    end
  end # Class
end # Module
