#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

require_relative 'variable_abstract'

module Languages

  # Handling attributes data.
  class AttributeData < Languages::VariableAbstract

    public

      def initialize(pAttributeName)
        super
        @visibility = 'public'
      end

  # Class
  end

# Module
end
