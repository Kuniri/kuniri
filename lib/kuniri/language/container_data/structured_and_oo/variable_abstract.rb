require_relative 'basic_data'

module Languages

  # Class responsible to provide global abstraction for variable and attribute.
  class VariableAbstract < Languages::BasicData

    public

      attr_accessor :value # !@attribute Value to assign (default = 'nothing').
      attr_accessor :type  # !@attribute Type of the attribute (default = nil).

      def initialize(pName)
        pName = 'fakeName' if pName.nil? or !pName.is_a? String

        @name = pName
        @value = 'nothing'
        @type = ''
      end

  # Class
  end

# Languages
end
