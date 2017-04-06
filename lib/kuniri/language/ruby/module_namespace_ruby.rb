#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

require_relative '../abstract_container/structured_and_oo/module_namespace'
require_relative '../container_data/structured_and_oo/module_namespace_data'

module Languages

  module Ruby

    # Class for handling ruby module
    class ModuleNamespaceRuby < Languages::ModuleNamespace
      # Get Ruby module.
      # @see Languages::ModuleNamespace
      def get_module(pLine)
        result = detect_module(pLine)
        return nil unless result

        result = remove_unnecessary_information(result)
        moduleCaptured = Languages::ModuleNamespaceData.new(result)

        return moduleCaptured
      end

      protected

      # Override
      def detect_module(pLine)
        regexExpression = /^\s*module\s+(.*)/
        return nil unless pLine =~ regexExpression
        return pLine.scan(regexExpression).join('')
      end

      # Override
      def remove_unnecessary_information(pLine)
        return pLine.gsub(/\s/, '') if pLine =~ /\s/
        return pLine
      end
    end # class
  end # module
end # module
