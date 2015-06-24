require_relative 'basic_data'

module Languages

  # Class responsible for handling repetition data
  class RepetitionData < Languages::BasicData

    public

      attr_accessor :type
      attr_accessor :expression

      def initialize
        @name = "nothing"
        @type = "none"
        @expression = "empty"
      end

  # class
  end

# module
end
