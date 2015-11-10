require_relative '../../spec_helper'

RSpec.describe Languages::Ruby::AggregationRuby do

  before :all do
    @rubyAggr = Languages::Ruby::AggregationRuby.new
    @singleResult = "abc"
  end

  context "When is a single aggregation with @" do
    it "Simple case with @" do
      captured = @rubyAggr.get_aggregation("abc.new\n")
      expect(captured).to eq(@singleResult)
    end

     it "Whitespace before" do
       captured = @rubyAggr.get_aggregation("       abc.new\n")
       expect(captured).to eq(@singleResult)
     end

     it "With whitespace before and after" do
       captured = @rubyAggr.get_aggregation("    abc.new  \n")
       expect(captured).to eq(@singleResult)
     end

     it "Whitespace before dot" do
       captured = @rubyAggr.get_aggregation("abc   .new\n")
       expect(captured).to eq(@singleResult)
     end

     it "Whitespace after dot" do
       captured = @rubyAggr.get_aggregation("abc.    new\n")
       expect(captured).to eq(@singleResult)
     end

     it "Between whitespace" do
       captured = @rubyAggr.get_aggregation("abc     .    new\n")
       expect(captured).to eq(@singleResult)
     end

   end

  context "When there is an aggregation with parameters" do

     it "With a single parameter" do
       captured = @rubyAggr.get_aggregation("abc.new a")
       expect(captured).to eq(@singleResult)
     end

     it "With multiple parameters" do
       captured = @rubyAggr.get_aggregation("abc.new a b c")
       expect(captured).to eq(@singleResult)
     end

     it "With single parameter with parenthesis" do
       captured = @rubyAggr.get_aggregation("abc.new(a)")
       expect(captured).to eq(@singleResult)
     end

     it "With multiple parameter with parenthesis" do
       captured = @rubyAggr.get_aggregation("abc.new(a,b, c)")
       expect(captured).to eq(@singleResult)
     end

  end

  context "When there is an aggregation with parameters" do

     it "Method calling with new on it" do
       captured = @rubyAggr.get_aggregation("abc.newton")
       expect(captured).to eq(nil)
     end
  end

  after :all do
    @rubyAggr = nil
    @singleResult = nil
  end
 
end
