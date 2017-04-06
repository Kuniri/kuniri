#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

require_relative '../container_data/structured_and_oo/function_data'
require_relative 'function_behavior_ruby'

module Languages

  module Ruby

    # Handling ruby global function
    class GlobalFunctionRuby < Languages::Ruby::FunctionBehaviorRuby
      # Get Ruby global function.
      # @see FunctionBehaviorRuby
      def get_method(pLine, _type = 'public')
        result = get_function(pLine)
        return nil unless result

        functionData = FunctionData.new(result.name)
        functionData << result

        return functionData
      end
    end # Class
  end # Ruby
end # Language
