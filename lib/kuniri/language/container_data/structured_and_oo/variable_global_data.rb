require_relative 'basic_data'

module Languages

  class VariableGlobalData < Languages::BasicData

    public

      attr_accessor :value
      attr_accessor :type

      def initialize(pName)
        @name = pName
        @visibility = "global"
      end

  # Class
  end

# Languages
end
