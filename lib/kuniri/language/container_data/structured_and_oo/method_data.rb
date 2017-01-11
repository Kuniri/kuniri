#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

require_relative 'function_abstract'

module Languages

  # Handling method informations
  class MethodData < Languages::FunctionAbstract

    public

      # Initialize Method object, based on name.
      # @param pMethodName Method name.
      def initialize(pMethodName)
        super(pMethodName)
        @type = METHOD_DATA
      end

  # Class
  end

# Module
end
