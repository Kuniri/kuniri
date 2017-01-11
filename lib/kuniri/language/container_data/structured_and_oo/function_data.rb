#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

require_relative 'function_abstract'

module Languages

  # Handle function data
  class FunctionData < Languages::FunctionAbstract

    public

      # Initialize function data based on name.
      # @param pFunctionName name string.
      def initialize(pFunctionName)
        super(pFunctionName)
        @type = GLOBAL_FUNCTION_DATA
      end

  # class
  end

# Module
end
