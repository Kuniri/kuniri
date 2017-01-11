#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

require_relative '../abstract_container/structured_and_oo/attribute'
require_relative 'variable_behaviour_ruby'

module Languages

  module Ruby

    # Ruby Handling Ruby attributes
    class AttributeRuby < Languages::Attribute

      public

        def initialize
          super
          setup_variable_behaviour
        end

        def get_attribute(pLine)
          attrCandidates = @variableBehaviour.common_declaration(pLine)
          return nil if attrCandidates.empty?

          attributes = []

          newCandidate, tmpAttrAt = handle_attributes_with_at(attrCandidates)
          attributes.concat(tmpAttrAt)

          newCandidate, tmpAttr = handle_attribute_with_attr(attrCandidates)
          attributes.concat(tmpAttr)

          return nil if attributes.empty?
          return attributes
        end

      private

        def create_attribute_data(variable, value = '')
          attribute = AttributeData.new(variable)
          attribute.value = value.strip unless value.empty?
          return attribute
        end

        def handle_attributes_with_at(pAttributeCandidates)
          attributes = []
          pAttributeCandidates.each do |variable, value|
            if variable =~ /^\s*(?:@|@@)\w+/
              variable = variable.delete('@')
              attribute = create_attribute_data(variable, value)
              attributes.push(attribute)
              pAttributeCandidates.delete(variable)
            else
              next
            end
          end
          return pAttributeCandidates, attributes
        end

        def handle_attribute_with_attr(pAttributeCandidates)
          attributes = []
          pAttributeCandidates.each do |variable, value|
            if variable =~ /^\s*(?:(?:attr_(?:accessor|reader|writer))\s+:\w+)/
              var = variable.split(' ').last
              var = var.delete(':')
              attribute = create_attribute_data(var)
              attributes.push(attribute)
              pAttributeCandidates.delete(variable)
              next
            end
            if variable =~ /^\s*(?::\w+)/
              variable = variable.delete(':')
              attribute = create_attribute_data(variable)
              attributes.push(attribute)
              pAttributeCandidates.delete(variable)
            end
          end
          return pAttributeCandidates, attributes
        end

    #Class
    end
  # Ruby
  end
#Language
end
