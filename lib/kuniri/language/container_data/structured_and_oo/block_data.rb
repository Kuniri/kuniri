#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

require_relative 'basic_structure'

module Languages

  # BlockData handling extern requirements
  class BlockData < Languages::BasicStructure

    attr_accessor :parameters

    def initialize
      super
      @parameters = []
    end

  end # Class
end # Module
