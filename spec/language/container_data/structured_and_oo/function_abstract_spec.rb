require_relative '../../../spec_helper'

RSpec.describe Languages::FunctionAbstract do

  before :each do
    @functionAbstract = Languages::FunctionAbstract.new "Test"
    @conditional = Languages::ConditionalData.new
    @repetition = Languages::RepetitionData.new
  end

  context "When adding a parameter" do
    it "Adds a parameter" do
      @functionAbstract.add_parameters("a")
      expect(@functionAbstract.parameters).to eq(["a"])
    end

    it "Adds a parameter with assignment" do
      @functionAbstract.add_parameters({"key" => "a"})
      expect(@functionAbstract.parameters).to eq([{"key" => "a"}])
    end

    it "Adds multiple parameters" do
      @functionAbstract.add_parameters("a")
      @functionAbstract.add_parameters("b")
      @functionAbstract.add_parameters("c")
      expect(@functionAbstract.parameters).to eq(["a", "b", "c"])
    end

    it "Adds multiple parameters with assignment" do
      @functionAbstract.add_parameters({"key1" => "a"})
      @functionAbstract.add_parameters({"key2" => "b"})
      @functionAbstract.add_parameters({"key3" => "c"})
      expect(@functionAbstract.parameters).to eq([{"key1" => "a"},
                                                  {"key2" => "b"},
                                                  {"key3" => "c"}])
    end

    it "adds an integer as a parameter" do
      @functionAbstract.add_parameters(12)
      expect(@functionAbstract.parameters).to_not eq([12])
    end

    it "Adds a hash with more than one element as a parameter" do
      @functionAbstract.add_parameters({"key1" => "a", "key2" => "b"})
      expect(@functionAbstract.parameters).to_not eq([{"key1" => "a",
                                                       "key2" => "b"}])
    end

  end

  context "When adding a conditional" do
    it "Adds a conditional" do
      @functionAbstract.add_conditional(@conditional)
      expect(@functionAbstract.conditionals).to eq([@conditional])
    end

    it "Adds a string as a conditional" do
      @functionAbstract.add_conditional("xpto")
      expect(@functionAbstract.conditionals).to_not eq(["xpto"])
    end
  end

  context "When adding a repetition" do
    it "Adds a repetition" do
      @functionAbstract.add_repetition(@repetition)
      expect(@functionAbstract.repetitions).to eq([@repetition])
    end

    it "Adds a string as a repetition" do
      @functionAbstract.add_repetition("xpto")
      expect(@functionAbstract.repetitions).to_not eq(["xpto"])
    end
  end

  after :each do
    @functionAbstract = nil
    @conditional = nil
    @repetition = nil
  end

end 
