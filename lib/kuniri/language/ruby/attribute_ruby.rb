require_relative '../abstract_container/structured_and_oo/attribute'
require_relative 'variable_behaviour_ruby'

module Languages

  module Ruby

    # Ruby Handling Ruby attributes
    class AttributeRuby < Languages::Attribute

      public

        def initialize
          detectRegex = /^\s*(?:@|attr_(?:accessor|reader|writer))(.*)$/
          # XXX: KLUDGE, REMOVE 'Attribute' and make it in the right way
          super(Languages::Ruby::VariableBehaviourRuby.new('Attribute'), detectRegex)
        end

    #Class
    end

  # Ruby
  end
#Language
end
