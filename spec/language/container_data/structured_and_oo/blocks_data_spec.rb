require_relative '../../../spec_helper'

RSpec.describe Languages::BlocksData do

  before :each do
    @blockData = Languages::BlocksData.new("5.times do |x|")
  end

  it "Get string" do
    expect(@blockData.blockDescription).to eq("5.times do |x|")
  end

  after :each do
    @blockData = nil
  end

end
