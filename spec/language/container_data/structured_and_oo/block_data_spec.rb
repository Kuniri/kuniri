require_relative '../../../spec_helper'

RSpec.describe Languages::BlockData do

  before :each do
    @blockData = Languages::BlockData.new
    @blockData.type = "BLOCK"
    @blockData.expression = "TIMES"
  end

  it "Get string" do
    expect(@blockData.type).to eq("BLOCK")
  end

  after :each do
    @blockData = nil
  end

end
