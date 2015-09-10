require_relative 'basic_data'

module Languages

  # Handling module data
  class ModuleNamespaceData < Languages::BasicData

    public

      def initialize(pName)
      	return nil if pName.nil? or !pName.is_a? String

        @name = pName
      end

  # Class
  end

# Module
end
