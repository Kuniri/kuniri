#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

require_relative '../abstract_container/structured_and_oo/extern_requirement'
require_relative '../container_data/structured_and_oo/extern_requirement_data'

module Languages

  module Ruby

    # ExternRequirement Handling extern requirements.
    class ExternRequirementRuby < Languages::ExternRequirement
      # Get Ruby requirement.
      # @see ExternRequirement
      def get_requirement(pLine)
        detectExpression = detect_extern_requirement(pLine)
        return nil unless detectExpression

        detectExpression = remove_unnecessary_information(detectExpression)
        name = File.basename(detectExpression, '.*')
        return ExternRequirementData.new(name)
      end

      protected

      # Override
      def detect_extern_requirement(pLine)
        regexExpression = /^\s*(:?require(?:_relative)?|load)\s+('|")(.*)\2/
        return nil unless pLine =~ regexExpression
        return pLine[regexExpression, 3]
      end

      # Override
      def remove_unnecessary_information(pLine)
        regexClean = /\s+|"|'/
        return pLine.gsub!(regexClean, '') if pLine =~ regexClean
        return pLine
      end
    end # Class
  end # Module
end # Module
