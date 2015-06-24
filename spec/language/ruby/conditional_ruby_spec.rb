require_relative '../../spec_helper'

RSpec.describe Languages::Ruby::ConditionalRuby do

  before :each do
    @conditionalRuby = Languages::Ruby::ConditionalRuby.new
  end

  context "When it is if statment." do
    it "Simple if statment." do
      input = "if x < 3"
      conditionalCaptured = @conditionalRuby.get_conditional(input).expression
      expect(conditionalCaptured).to eq("x < 3")

      input = "if 2 < 3"
      conditionalCaptured = @conditionalRuby.get_conditional(input).expression
      expect(conditionalCaptured).to eq("2 < 3")

      input = "if abc && xpto"
      conditionalCaptured = @conditionalRuby.get_conditional(input).expression
      expect(conditionalCaptured).to eq("abc && xpto")

      input = "if x == 222222"
      conditionalCaptured = @conditionalRuby.get_conditional(input).expression
      expect(conditionalCaptured).to eq("x == 222222")
    end

    it "Simple if statment with spaces." do
      input = "                         if x == y"
      conditionalCaptured = @conditionalRuby.get_conditional(input).expression
      expect(conditionalCaptured).to eq("x == y")

      input = "    if k && u &&  y || x         "
      conditionalCaptured = @conditionalRuby.get_conditional(input).expression
      expect(conditionalCaptured).to eq("k && u &&  y || x")

      input = "  if     k && u  &&                      y"
      conditionalCaptured = @conditionalRuby.get_conditional(input).expression
      expect(conditionalCaptured).to eq("k && u  &&                      y")

      input = " if   k"
      conditionalCaptured = @conditionalRuby.get_conditional(input).expression
      expect(conditionalCaptured).to eq("k")
    end

  end

  context "Using unless statment" do
    it "Simple unless statment." do
      input = "unless a > b"
      unlessCaptured = @conditionalRuby.get_conditional(input).expression
      expect(unlessCaptured).to eq("a > b")
    end

    it "Simple unless statment with spaces." do
      input = "                 unless   a  >   b "
      unlessCaptured = @conditionalRuby.get_conditional(input).expression
      expect(unlessCaptured).to eq("a  >   b")

      input = "            unless   a      &&      b "
      unlessCaptured = @conditionalRuby.get_conditional(input).expression
      expect(unlessCaptured).to eq("a      &&      b")
    end
  end

  context "Using elsif" do
    it "Simple elsif statment." do
      input = "elsif n > m"
      elsifCaptured = @conditionalRuby.get_conditional(input).expression
      expect(elsifCaptured).to eq("n > m")
    end

    it "Simple elsif statement with spaces." do
      input = "                 elsif n > m   "
      elsifCaptured = @conditionalRuby.get_conditional(input).expression
      expect(elsifCaptured).to eq("n > m")
    end
  end

  context "When is case statment." do
    it "Simple case statment." do
      input = "case options"
      conditionalCaptured = @conditionalRuby.get_conditional(input).expression
      expect(conditionalCaptured).to eq("options")

      input = "case abc"
      conditionalCaptured = @conditionalRuby.get_conditional(input).expression
      expect(conditionalCaptured).to eq("abc")
    end

    it "Case with spaces" do
      input = "                                              case    abc  "
      conditionalCaptured = @conditionalRuby.get_conditional(input).expression
      expect(conditionalCaptured).to eq("abc")

      input = " case     abc         "
      conditionalCaptured = @conditionalRuby.get_conditional(input).expression
      expect(conditionalCaptured).to eq("abc")
    end
  end 

  after :each do
    @conditionalRuby = nil
  end

end
