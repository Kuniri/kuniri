require_relative '../../../spec_helper'

RSpec.describe Languages::ConditionalData do

  before :each do
    @conditionalData = Languages::ConditionalData.new
  end

  context "When if conditional." do
    it "Set type." do
      @conditionalData.type = "if"
      expect(@conditionalData.type).to eq("if")
    end

    it "Simple expression." do
      @conditionalData.expression = "x > 3"
      expect(@conditionalData.expression).to eq("x > 3")

      @conditionalData.expression = "5 < 3"
      expect(@conditionalData.expression).to eq("5 < 3")

      @conditionalData.expression = "abc == 'x'"
      expect(@conditionalData.expression).to eq("abc == 'x'")

      @conditionalData.expression = "x >= 3"
      expect(@conditionalData.expression).to eq("x >= 3")
    end
  end

  after :each do
    @conditional = nil
  end

end 
