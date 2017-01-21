#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

require_relative 'variable_abstract'

module Languages

  # Class responsible for handling global variables.
  class VariableGlobalData < Languages::VariableAbstract

    public

      def initialize(pName)
        super
        @visibility = 'global'
      end

  # Class
  end

# Languages
end
