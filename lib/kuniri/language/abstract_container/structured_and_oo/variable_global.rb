#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

require_relative 'variable_behaviour_helpers'

module Languages

  # @abstract Any global variable should be handler here.
  class VariableGlobal

    public

      include VariableBehaviourHelpers

      # This method is the main interface for extract data from specific
      # code and convert it to a common representation.
      # @param pLine Line to be inspected.
      # @return If line has a variable, this method returns an object of
      #       VariableGlobalData. Otherwise returns nil.
      # @see variable_global_data.rb
      def get_variable(pLine)
        raise NotImplementedError
      end

    protected

      @variableBehaviour

  # class
  end

# module
end
