#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

module Languages

  # Keep important information for second parser.
  class Metadata

    public

      private_class_method :new
      attr_accessor :allClasses # !@attribute All classes to be analysed.
      attr_accessor :allAggregations # !@attribute All aggregation in classes.

      def initialize
        @allClasses = []
        @allAggregations = []
      end

      def Metadata.create
        @@metadata = new unless @@metadata
        return @@metadata
      end

    private

      @@metadata = nil

  # Class
  end
# Module
end
