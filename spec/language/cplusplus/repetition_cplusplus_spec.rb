require_relative '../../spec_helper'

RSpec.describe Languages::Cplusplus::RepetitionCplusplus do

  before :each do
    @repetitionCplusplus = Languages::Cplusplus::RepetitionCplusplus.new
  end

  context "When it is while statment." do
    it "Simple while statment." do
      input = "while (i < 10)"
      repetitionCaptured = @repetitionCplusplus.get_repetition(input).expression
      expect(repetitionCaptured).to eq("i < 10")

      input = "while (2 < 3)"
      repetitionCaptured = @repetitionCplusplus.get_repetition(input).expression
      expect(repetitionCaptured).to eq("2 < 3")

      input = "while (x == 222222)"
      repetitionCaptured = @repetitionCplusplus.get_repetition(input).expression
      expect(repetitionCaptured).to eq("x == 222222")
    end

    it "Simple while statment with whitespaces." do
      input = "while   (   i  <   10  )"
      repetitionCaptured = @repetitionCplusplus.get_repetition(input).expression
      expect(repetitionCaptured).to eq("i < 10")

      input = "while    (2 < 3)    "
      repetitionCaptured = @repetitionCplusplus.get_repetition(input).expression
      expect(repetitionCaptured).to eq("2 < 3")

      input = "  while   (    x   ==    222222   )   "
      repetitionCaptured = @repetitionCplusplus.get_repetition(input).expression
      expect(repetitionCaptured).to eq("x == 222222")
    end
  end

  context "When it is for statment." do
  	it "Simple for statment." do
      input = "for (int i = 10; i < 20; ++i)"
      repetitionCaptured = @repetitionCplusplus.get_repetition(input).expression
      expect(repetitionCaptured).to eq("int i = 10; i < 20; ++i")
    end

    it "Simple for statment with whitespaces." do
      input = "for (    int   i   = 10  ;   i < 20  ; ++i   )   "
      repetitionCaptured = @repetitionCplusplus.get_repetition(input).expression
      expect(repetitionCaptured).to eq("int i = 10 ; i < 20 ; ++i")
    end
  end

  after :each do
    @repetitionCplusplus = nil
  end

end
