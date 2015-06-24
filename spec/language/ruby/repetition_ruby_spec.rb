require_relative '../../spec_helper'

RSpec.describe Languages::Ruby::RepetitionRuby do

  before :each do
    @repetitionRuby = Languages::Ruby::RepetitionRuby.new
  end

  context "When it is if statment." do
    it "Simple if statment." do
      input = "while gets"
      repetitionCaptured = @repetitionRuby.get_repetition(input).expression
      expect(repetitionCaptured).to eq("gets")

      input = "while 2 < 3"
      repetitionCaptured = @repetitionRuby.get_repetition(input).expression
      expect(repetitionCaptured).to eq("2 < 3")

      input = "for x.range(0,1)"
      repetitionCaptured = @repetitionRuby.get_repetition(input).expression
      expect(repetitionCaptured).to eq("x.range(0,1)")

      input = "while x == 222222"
      repetitionCaptured = @repetitionRuby.get_repetition(input).expression
      expect(repetitionCaptured).to eq("x == 222222")
    end
  end

  after :each do
    @repetitionRuby = nil
  end

end
