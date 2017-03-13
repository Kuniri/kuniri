#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

require_relative 'basic_data'

module Languages

  # Class responsible to be an abstraction for conditional and repetition data. 
  class BasicStructure < Languages::BasicData

    public

      attr_accessor :type
      attr_accessor :expression
      attr_accessor :level
      attr_accessor :singleLine
      attr_reader :managerCondAndLoop

      def initialize
        @type = 'none'
        @expression = 'empty'
        @level = 0
        @singleLine = false
        @managerCondAndLoop = Languages::ManagerBasicStructureData.new
      end
  # class
  end
# module
end
