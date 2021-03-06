#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

require_relative 'variable_behaviour_helpers'

module Languages

  # @abstract Abstract class for handling attribute.
  class Attribute
    include VariableBehaviourHelpers

    # Verify if a line has an attribute. If it has attribute, firstly, the
    # function capture all lines and removes specific language declaration
    # (for instance, in ruby it is:  '@' or ':' and whitespace), finally
    # it splits the string by an special character and return an object of
    # AttributeData.
    # @param pLine An line to be analysed for find attribute.
    # @return Return on filled object of AttributeData if it find an
    #         attribute, otherwise it returns nil.
    def get_attribute(_pLine)
      raise NotImplementedError
    end
  end # Class
end # Language
