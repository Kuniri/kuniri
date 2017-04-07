#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

require_relative '../container_data/structured_and_oo/constructor_data'
require_relative 'function_behavior_ruby'

module Languages

  module Ruby

    # Handling ruby constructor
    class ConstructorRuby < Languages::Ruby::FunctionBehaviorRuby
      # Get Ruby constructor.
      # @see FunctionBehaviorRuby
      def get_constructor(pLine, _type = 'public')
        result = get_function(pLine)
        return nil unless result
        return nil unless result.name =~ /^initialize$/

        constructorData = ConstructorData.new(result.name)
        constructorData << result

        return constructorData
      end
    end # Class
  end # Ruby
end # Language
