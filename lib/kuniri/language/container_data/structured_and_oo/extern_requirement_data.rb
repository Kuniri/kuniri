#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

require_relative 'basic_data'

module Languages

  # ExternRequirementData Handling extern requirements
  class ExternRequirementData < Languages::BasicData
    attr_reader :library

    def initialize(pRequirement)
      return nil if (pRequirement.nil?) || (!pRequirement.is_a? String)
      @library = pRequirement
    end

    # Set library of extern requirement.
    # @param pLibrary Library inside the extern requirement.
    def set_library(pLibrary)
      return nil if (pLibrary.nil?) ||
                    (!pLibrary.is_a? String) ||
                    (pLibrary.empty?)

      @library = pLibrary
    end
  end # Class
end # Module
