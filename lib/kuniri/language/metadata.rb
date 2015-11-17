module Languages

  class Metadata

    public

      private_class_method :new
      attr_accessor :allClasses
      attr_accessor :allAggregations

      def initialize
        @allClasses = []
        @allAggregations = []
      end

      def Metadata.create
        @@metadata = new unless @@metadata
        return @@metadata
      end

    private

      @@metadata = nil

  # Class
  end
# Module
end
