require_relative '../../../spec_helper'

RSpec.describe Languages::RepetitionData do

  before :each do
    @repetitionData = Languages::RepetitionData.new
  end

  context "When if conditional." do
    it "Set type." do
      @repetitionData.type = "while"
      expect(@repetitionData.type).to eq("while")
    end

    it "Simple expression." do
      @repetitionData.expression = "gets"
      expect(@repetitionData.expression).to eq("gets")

      @repetitionData.expression = "5 < 3"
      expect(@repetitionData.expression).to eq("5 < 3")

      @repetitionData.expression = "abc == 'x'"
      expect(@repetitionData.expression).to eq("abc == 'x'")

      @repetitionData.expression = "x >= 3"
      expect(@repetitionData.expression).to eq("x >= 3")
    end
  end

  after :each do
    @repetitionData = nil
  end

end 
