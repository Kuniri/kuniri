require_relative '../../spec_helper'

RSpec.describe Languages::Csharp::RepetitionCsharp do

  before :each do
    @repetitionCsharp = Languages::Csharp::RepetitionCsharp.new
  end

  context "When it is while statment." do
    it "Simple while statment." do
      input = "while (gets)"
      repetitionCaptured = @repetitionCsharp.get_repetition(input).expression
      expect(repetitionCaptured).to eq("gets")

      input = "while (2 < 3)"
      repetitionCaptured = @repetitionCsharp.get_repetition(input).expression
      expect(repetitionCaptured).to eq("2 < 3")

      input = "while (x == 222222)"
      repetitionCaptured = @repetitionCsharp.get_repetition(input).expression
      expect(repetitionCaptured).to eq("x == 222222")
    end

    it "Simple for statment." do
      input = "for (int index = 0; index < arg.Length; index++)"
      repetitionCaptured = @repetitionCsharp.get_repetition(input).expression
      expect(repetitionCaptured).to eq("int index = 0; index < arg.Length; index++")
    end
  end

  after :each do
    @repetitionCsharp = nil
  end

end
