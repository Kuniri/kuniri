require_relative 'basic_data'

module Languages

  # Class responsible for handling conditional data
  class ConditionalData < Languages::BasicData

    public

      attr_accessor :type
      attr_accessor :expression
      attr_accessor :level

      def initialize
        @type = "none"
        @expression = "empty"
        @level = 0
      end

  # class
  end

# module
end
