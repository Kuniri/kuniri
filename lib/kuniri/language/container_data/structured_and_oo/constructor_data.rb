#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

require_relative 'function_abstract'

module Languages

  # Handling constructor information.
  class ConstructorData < Languages::FunctionAbstract

    public

      # Constructor based on name.
      def initialize(pConstructorName)
        super(pConstructorName)
        @type = CONSTRUCTOR_DATA
      end

  # Class
  end

# Module
end
