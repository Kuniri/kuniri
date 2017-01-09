require_relative 'basic_data'

module Languages

  # Class responsible to be an abstraction for conditional and repetition data. 
  class BasicStructure < Languages::BasicData

    public

      attr_accessor :type
      attr_accessor :expression
      attr_accessor :level

      def initialize
        @type = 'none'
        @expression = 'empty'
        @level = 0
      end
  # class
  end
# module
end
