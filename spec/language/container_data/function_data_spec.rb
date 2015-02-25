require_relative '../../spec_helper'

RSpec.delete Languages::FunctionData do

  before :all do
    @functionData = Languages::FunctionData.new
  end

  context "# Function data test" do
    it "Function name" do
    end

    it "Function parameters" do
    end

  end

  after :all do
    @functionData = nil
  end

end
