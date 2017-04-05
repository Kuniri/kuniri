#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

module Languages

  # @abstract Aggregation is a container for handling aggregation among classes
  class Aggregation
    # Verify if line has an aggregation.
    # @param pLine Line with the potential class.
    # @return Return an object AggregationData if it find a class in the
    #         line, otherwise return nil.
    def get_aggregation(_pLine)
      raise NotImplementedError
    end

    protected

    # Detect if an aggregation exists.
    # @param pLine Line to inspect.
    # @return Returns an row string, otherwise returns nil.
    def detect_aggregation(_pLine)
      raise NotImplementedError
    end

  end # class
end # module
