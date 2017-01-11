#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

require_relative 'basic_data'

module Languages

  # ExternRequirementData Handling extern requirements
  class ExternRequirementData < Languages::BasicData

    public

      attr_reader :library

      def initialize(pRequirement)
        return nil if pRequirement.nil? or !pRequirement.is_a? String
        @library = pRequirement
      end

      # Set library of extern requirement.
      # @param pLibrary Library inside the extern requirement.
      def set_library(pLibrary)
        if pLibrary.nil? or !pLibrary.is_a? String or pLibrary.empty?
          return nil
        end

        @library = pLibrary
      end

  # Class
  end

# Module
end
