module Languages

  # Keep important information for second parser.
  class Metadata

    public

      private_class_method :new
      attr_accessor :allClasses # !@attribute All classes to be analysed.
      attr_accessor :allAggregations # !@attribute All aggregation in classes.

      def initialize
        @allClasses = []
        @allAggregations = []
        @allInheritances = []
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
