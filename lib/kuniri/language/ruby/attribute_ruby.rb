require_relative '../abstract_container/structured_and_oo/attribute'
require_relative 'variable_behaviour_ruby'

module Languages

  module Ruby

    # Ruby Handling Ruby attributes
    class AttributeRuby < Languages::Attribute

      public

        def initialize
          super
          @detectRegex = /^\s*(?:@|attr_(?:accessor|reader|writer))(.*)$/
          setup_variable_behaviour(@detectRegex)
        end

        def get_attribute(pLine)
          attributes_candiates = @variableBehaviour.common_declaration(pLine, 'useless')
          return nil if attributes_candiates.empty?

          attributes = []

          # Handling variables with @
          attributes_candiates.each do |variable, value|
            if variable =~ /^\s*(?:@|@@)\w+/
              attribute = create_attribute_data(variable.delete('@'), value)
              attributes.push(attribute)
              attributes_candiates.delete(variable)
            else
              next
            end
          end
          # Handling variables with attr
          attributes_candiates.each do |variable, value|
            # attr_* :llala
            if variable =~ /^\s*(?:(?:attr_(?:accessor|reader|writer))\s+:\w+)/
              var = variable.split(" ").last
              attribute = create_attribute_data(var.delete(':'))
              attributes.push(attribute)
              attributes_candiates.delete(variable)
              next
            end
            # :lala, :luele
            if variable =~ /^\s*(?::\w+)/
              attribute = create_attribute_data(variable.delete(':'))
              attributes.push(attribute)
              attributes_candiates.delete(variable)
            end
          end

          return nil if attributes.empty?
          return attributes
        end

      private

        def create_attribute_data(variable, value = '')
          attribute = AttributeData.new(variable)
          attribute.value = value.strip unless value.empty?
          return attribute
        end

    #Class
    end
  # Ruby
  end
#Language
end
