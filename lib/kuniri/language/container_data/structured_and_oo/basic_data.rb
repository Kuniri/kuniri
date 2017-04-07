#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

module Languages

  # @abstract Usually, all data in this container needs at list one
  # information: name. This class aim to be a generic class for all elements
  # of container data.
  class BasicData
    attr_accessor :name
    attr_accessor :visibility
    attr_accessor :comments
  end # class
end # module
