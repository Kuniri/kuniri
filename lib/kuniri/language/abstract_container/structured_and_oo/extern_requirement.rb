#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

module Languages

  # ExternRequirement is responsible for handling external requirement.
  # An external requirement is the "#include" in C, "require" in Ruby,
  # "import" in Java, etc.
  class ExternRequirement
    # Get requirement name.
    # @param pLine Line to be analysed.
    # @return Return the ExternRequirementData object, or nil.
    def get_requirement(_pLine)
      raise NotImplementedError
    end

    protected

    # @param pLine Line to detect requirement.
    # @return Returns a string with row extern requirement, or nil if not
    #         detects anything.
    def detect_extern_requirement(_pLine)
      raise NotImplementedError
    end

    # @param pLine Line with row string to be pruned.
    # @return Returns an string.
    def remove_unnecessary_information(_pLine)
      raise NotImplementedError
    end
  end # Class
end # Module
