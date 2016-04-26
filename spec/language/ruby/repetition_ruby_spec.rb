require_relative '../../spec_helper'

RSpec.describe Languages::Ruby::RepetitionRuby do

  before :each do
    @repetitionRuby = Languages::Ruby::RepetitionRuby.new
  end

  context "While loop" do
    it "Simple while statement." do
      input = "while gets do"
      repetitionCaptured = @repetitionRuby.get_repetition(input)
      expect(repetitionCaptured.expression).to eq("gets")
      expect(repetitionCaptured.type).to eq(Languages::WHILE_LABEL)
    end

    it "Numerical statement" do
      input = "while 2 < 3 do"
      repetitionCaptured = @repetitionRuby.get_repetition(input).expression
      expect(repetitionCaptured).to eq("2 < 3")
    end

    it "Big number" do
      input = "while x == 222222 do"
      repetitionCaptured = @repetitionRuby.get_repetition(input).expression
      expect(repetitionCaptured).to eq("x == 222222")
    end

    it "Compare with string" do
      input = 'while x == "abc" do'
      repetitionCaptured = @repetitionRuby.get_repetition(input).expression
      expect(repetitionCaptured).to eq('x == "abc"')
    end

    it "While with multiple spaces between expression" do
      input = 'while                                x == "abc" do'
      repetitionCaptured = @repetitionRuby.get_repetition(input).expression
      expect(repetitionCaptured).to eq('x == "abc"')
    end

    it "While with multiple spaces in the beginning" do
      input = '         while x == "abc" do'
      repetitionCaptured = @repetitionRuby.get_repetition(input)
      expect(repetitionCaptured.expression).to eq('x == "abc"')
      expect(repetitionCaptured.type).to eq(Languages::WHILE_LABEL)
    end

    it "'Do' is not mandatory" do
      input = "while x > 3"
      repetitionCaptured = @repetitionRuby.get_repetition(input)
      expect(repetitionCaptured.type).to eq(Languages::WHILE_LABEL)
    end

    it "Not match" do
      input = "whiles x > 3"
      repetitionCaptured = @repetitionRuby.get_repetition(input)
      expect(repetitionCaptured).to eq(nil)
    end

  end

  context "For loop" do
    it "Simple for statement." do
      input = "for i in 0..5"
      repetitionCaptured = @repetitionRuby.get_repetition(input).expression
      expect(repetitionCaptured).to eq("i in 0..5")
    end

    it "Multiple spaces in the beginning of for" do
      input = "              for i in 0..5"
      repetitionCaptured = @repetitionRuby.get_repetition(input)
      expect(repetitionCaptured.expression).to eq("i in 0..5")
      expect(repetitionCaptured.type).to eq(Languages::FOR_LABEL)
    end

    it "Multiple spaces between of for and expression" do
      input = "              for      i in 0..5"
      repetitionCaptured = @repetitionRuby.get_repetition(input)
      expect(repetitionCaptured.expression).to eq("i in 0..5")
      expect(repetitionCaptured.type).to eq(Languages::FOR_LABEL)
    end

    it "No match" do
      input = "for xpto"
      repetitionCaptured = @repetitionRuby.get_repetition(input)
      expect(repetitionCaptured).to eq(nil)
    end

    it "We can have 'do' or not at the end" do
      input = "for i in 0..5 do"
      repetitionCaptured = @repetitionRuby.get_repetition(input)
      expect(repetitionCaptured.expression).to eq("i in 0..5")
    end

    it "For with 'do' and space in the end" do
      input = "for i in 0..5 do              "
      repetitionCaptured = @repetitionRuby.get_repetition(input)
      expect(repetitionCaptured.expression).to eq("i in 0..5")
    end

  end

  context "Until loop" do
    it "Simple until statement" do
      input = "until $i > $num  do"
      repetitionCaptured = @repetitionRuby.get_repetition(input).expression
      expect(repetitionCaptured).to eq("$i > $num")
    end

    it "Compare with string" do
      input = 'until xpto == "exit" do'
      repetitionCaptured = @repetitionRuby.get_repetition(input).expression
      expect(repetitionCaptured).to eq('xpto == "exit"')
    end

    it "Check correct type" do
      input = 'until xpto == "exit" do'
      repetitionCaptured = @repetitionRuby.get_repetition(input)
      expect(repetitionCaptured.type).to eq(Languages::UNTIL_LABEL)
    end

    it "'Do' is not mandatory with until" do
      input = 'until xpto == "exit"'
      repetitionCaptured = @repetitionRuby.get_repetition(input)
      expect(repetitionCaptured.type).to eq(Languages::UNTIL_LABEL)
    end

    it "Until without 'do' and with space at the end" do
      input = 'until xpto == "exit"                                  '
      repetitionCaptured = @repetitionRuby.get_repetition(input)
      expect(repetitionCaptured.type).to eq(Languages::UNTIL_LABEL)
    end

    it "Until without 'do' and with space at the begin and the end" do
      input = '    until xpto == "exit"                                  '
      repetitionCaptured = @repetitionRuby.get_repetition(input)
      expect(repetitionCaptured.type).to eq(Languages::UNTIL_LABEL)
    end

    it "Not match" do
      input = 'untils xpto == "exit"'
      repetitionCaptured = @repetitionRuby.get_repetition(input)
      expect(repetitionCaptured).to eq(nil)
    end

  end

  context "Do while" do
    it "Simple do while statement" do
      input = "end while $i < $num"
      repetitionCaptured = @repetitionRuby.get_repetition(input).expression
      expect(repetitionCaptured).to eq("$i < $num")
    end

    it "No match" do
      input = "end whiles $xpto > 23 do"
      repetitionCaptured = @repetitionRuby.get_repetition(input)
      expect(repetitionCaptured).to eq(nil)
    end

   # it "No match" do
   #   input = "end while $xpto > 23 do"
   #   repetitionCaptured = @repetitionRuby.get_repetition(input)
   #   expect(repetitionCaptured).to eq(nil)
   # end

  end

  after :each do
    @repetitionRuby = nil
  end

end
