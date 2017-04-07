#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

require_relative 'basic_data'

module Languages

  # Class responsible to provide global abstraction for variable and attribute.
  class VariableAbstract < Languages::BasicData
    attr_accessor :value # !@attribute Value to assign (default = 'nothing').
    attr_accessor :type  # !@attribute Type of the attribute (default = nil).

    def initialize(pName)
      pName = 'fakeName' if (pName.nil?) || (!pName.is_a? String)

      @name = pName
      @value = Languages::UNKNOWN
      @type = ''
    end
  end # Class
end # Language
