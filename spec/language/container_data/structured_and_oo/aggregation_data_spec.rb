require_relative '../../../spec_helper'

RSpec.describe Languages::AggregationData do

  before :all do
    @aggregationData = Languages::AggregationData.new("xpto")
  end

  context "# Aggregation data" do
    it "Get name" do
      expect(@aggregationData.name).to eq("xpto")

      @aggregationData.name = "banana"
      expect(@aggregationData.name).to eq("banana")
    end

    it "Does not set name" do
      @aggregationData = Languages::AggregationData.new(nil)
      expect(@aggregationData.name).to be_nil
      @aggregationData = Languages::AggregationData.new(1)
      expect(@aggregationData.name).to be_nil
    end
  end

  after :all do
    @aggregationData = nil
  end

end
