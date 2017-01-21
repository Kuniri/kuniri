#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

require_relative 'basic_data'

module Languages

  # Handling module data
  class ModuleNamespaceData < Languages::BasicData

    public

      def initialize(pName)
      	return nil if pName.nil? or !pName.is_a? String

        @name = pName
      end

  # Class
  end

# Module
end
