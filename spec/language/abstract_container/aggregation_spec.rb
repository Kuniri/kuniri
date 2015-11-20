require_relative '../../spec_helper'

RSpec.describe Languages::Aggregation do

  context "When not implemented" do
    it "Get aggregation" do
      aggregationAbstract = Languages::Aggregation.new
      expect{aggregationAbstract.get_aggregation("abc.new")}.to raise_error(
              NotImplementedError)
    end
  end

end
