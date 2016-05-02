require_relative 'basic_data'

module Languages

  # Class responsible for handling global variables.
  class VariableGlobalData < Languages::BasicData

    public

      attr_accessor :value
      attr_accessor :type

      def initialize(pName)
        return nil if pName.nil? or !pName.is_a? String

        @name = pName
        @visibility = "global"
        @value = 'nothing'
      end

  # Class
  end

# Languages
end
