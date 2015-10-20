require_relative '../../spec_helper'

RSpec.describe Languages::Cplusplus::ConditionalCplusplus do

  before :each do
    @conditionalCplusplus = Languages::Cplusplus::ConditionalCplusplus.new
  end

  context "When it is if statment." do
    it "Simple if statment." do
      input = "if (x < 3)"
      conditionalCaptured = @conditionalCplusplus.get_conditional(input).expression
      expect(conditionalCaptured).to eq("x < 3")

      input = "if (2 < 3)"
      conditionalCaptured = @conditionalCplusplus.get_conditional(input).expression
      expect(conditionalCaptured).to eq("2 < 3")

      input = "if (abc && xpto)"
      conditionalCaptured = @conditionalCplusplus.get_conditional(input).expression
      expect(conditionalCaptured).to eq("abc && xpto")

      input = "if (x == 222222)"
      conditionalCaptured = @conditionalCplusplus.get_conditional(input).expression
      expect(conditionalCaptured).to eq("x == 222222")
    end

    it "Simple if statment with spaces." do
      input = "                         if (x == y)"
      conditionalCaptured = @conditionalCplusplus.get_conditional(input).expression
      expect(conditionalCaptured).to eq("x == y")

      input = "    if (   k && u &&  y || x     )    "
      conditionalCaptured = @conditionalCplusplus.get_conditional(input).expression
      expect(conditionalCaptured).to eq("k && u && y || x")

      input = "  if   (  k && u  &&                      y )   "
      conditionalCaptured = @conditionalCplusplus.get_conditional(input).expression
      expect(conditionalCaptured).to eq("k && u && y")

      input = " if (  k)"
      conditionalCaptured = @conditionalCplusplus.get_conditional(input).expression
      expect(conditionalCaptured).to eq("k")
    end

  end

  context "Using else if" do
    it "Simple elsif statment." do
      input = "else if (n > m)"
      elsifCaptured = @conditionalCplusplus.get_conditional(input).expression
      expect(elsifCaptured).to eq("n > m")
    end

    it "Simple elsif statement with spaces." do
      input = "                 else    if  (  n >   m  )  "
      elsifCaptured = @conditionalCplusplus.get_conditional(input).expression
      expect(elsifCaptured).to eq("n > m")
    end
  end

  context "When is switch statment." do
    it "Simple switch statment." do
      input = "switch (options)"
      conditionalCaptured = @conditionalCplusplus.get_conditional(input).expression
      expect(conditionalCaptured).to eq("options")

      input = "switch (abc)"
      conditionalCaptured = @conditionalCplusplus.get_conditional(input).expression
      expect(conditionalCaptured).to eq("abc")
    end

    it "Case with spaces" do
      input = "                                              switch  (  abc ) "
      conditionalCaptured = @conditionalCplusplus.get_conditional(input).expression
      expect(conditionalCaptured).to eq("abc")

      input = " switch   (  abc)         "
      conditionalCaptured = @conditionalCplusplus.get_conditional(input).expression
      expect(conditionalCaptured).to eq("abc")
    end
  end

  after :each do
    @conditionalCplusplus = nil
  end

end
