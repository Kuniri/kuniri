#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

module Languages

  # @abstract Class responsible for handling namespaces, module, package or
  # anything similar.
  class ModuleNamespace
    # Get a string and try to find a pattern, that match or not with module.
    # @param pLine Receives a line for try to find module inside it.
    # @return Return an ModuleNamespaceData.
    def get_module(_pLine)
      raise NotImplementedError
    end

    protected

    # Verify if line has a potential module.
    # @param pLine String for try to find a pattern.
    # @return Return an string pre-processed, or nil in case of not match
    #         string.
    def detect_module(_pLine)
      raise NotImplementedError
    end

    # @param pLine Receives a line for handling.
    # @return Return an string.
    def remove_unnecessary_information(_pLine)
      raise NotImplementedError
    end
  end # class
end # Languages module
