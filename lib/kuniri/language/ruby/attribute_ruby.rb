require_relative '../abstract_container/structured_and_oo/attribute'
require_relative 'variable_behaviour_ruby'

module Languages

  module Ruby

    # Ruby Handling Ruby attributes
    class AttributeRuby < Languages::Attribute

      public

        def initialize
          super
          detectRegex = /^\s*(?:@|attr_(?:accessor|reader|writer))(.*)$/
          setup_variable_behaviour(detectRegex)
        end

    #Class
    end
  # Ruby
  end
#Language
end
