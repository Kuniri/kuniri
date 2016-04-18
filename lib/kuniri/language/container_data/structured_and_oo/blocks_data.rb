require_relative 'basic_structure'

module Languages

  # BlockData handling extern requirements
  class BlocksData < Languages::BasicStructure

    public

      attr_accessor :blockDescription

      def initialize(pBlock = "block")
        @blockDescription = pBlock
      end

  # Class
  end

# Module
end
