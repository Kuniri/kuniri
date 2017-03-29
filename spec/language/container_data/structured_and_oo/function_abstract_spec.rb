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
      functionConditional = @functionAbstract.managerCondLoopAndBlock.basicStructure
      expect(functionConditional).to eq([@conditional])
    end

    it "Adds a string as a conditional should fail" do
      @functionAbstract.add_conditional("xpto")
      functionConditional = @functionAbstract.managerCondLoopAndBlock.basicStructure
      expect(functionConditional).to_not eq(["xpto"])
    end

    it "Adds a set of conditional" do
      conditionals = []
      for index in 0..5 do
        conditionals[index] = Languages::ConditionalData.new
        conditionals[index].expression = "xpto == #{index}"
        conditionals[index].type = Languages::IF_LABEL
        @functionAbstract.add_conditional(conditionals[index])
      end
      allConditionals = @functionAbstract.managerCondLoopAndBlock.basicStructure
      expect(allConditionals).to match_array(conditionals)
    end

    it "Add a set of conditionals with different level" do
      conditionals = []
      for index in 0..3 do
        conditionals[index]  = Languages::ConditionalData.new
        conditionals[index].type = Languages::IF_LABEL
      end

      @functionAbstract.add_conditional(conditionals[0])
      @functionAbstract.add_conditional(conditionals[1], Languages::DOWN_LEVEL)
      @functionAbstract.add_conditional(conditionals[2], Languages::DOWN_LEVEL)
      @functionAbstract.add_conditional(conditionals[3], Languages::UP_LEVEL)

      allConditional = @functionAbstract.managerCondLoopAndBlock.basicStructure
      expect(allConditional[0].level).to eq(0)
      expect(allConditional[1].level).to eq(1)
      expect(allConditional[2].level).to eq(2)
      expect(allConditional[3].level).to eq(1)

    end
  end

  context "When adding a repetition" do
    it "Adds a repetition" do
      @functionAbstract.add_repetition(@repetition)
      functionLoop = @functionAbstract.managerCondLoopAndBlock.basicStructure
      expect(functionLoop).to eq([@repetition])
    end

    it "Adds a string as a repetition should fail" do
      @functionAbstract.add_repetition("xpto")
      functionLoop = @functionAbstract.managerCondLoopAndBlock.basicStructure
      expect(functionLoop).to_not eq(["xpto"])
    end

    it "Add a set of loops" do
      loops = []
      for index in 0..5 do
        loops[index] = Languages::RepetitionData.new
        loops[index].type = Languages::FOR_LABEL
        loops[index].expression = "true"
        @functionAbstract.add_repetition(loops[index])
      end
      allLoops = @functionAbstract.managerCondLoopAndBlock.basicStructure
      expect(allLoops).to match_array(loops)
    end

    it "Add a set of loops with different level" do
      loops = []
      for index in 0..3 do
        loops[index] = Languages::RepetitionData.new
        loops[index].type = Languages::WHILE_LABEL
      end

      @functionAbstract.add_repetition(loops[0])
      @functionAbstract.add_repetition(loops[1], Languages::DOWN_LEVEL)
      @functionAbstract.add_repetition(loops[2])
      @functionAbstract.add_repetition(loops[3], Languages::UP_LEVEL)

      allLoops = @functionAbstract.managerCondLoopAndBlock.basicStructure
      expect(allLoops[0].level).to eq(0)
      expect(allLoops[1].level).to eq(1)
      expect(allLoops[2].level).to eq(1)
      expect(allLoops[3].level).to eq(0)
    end
  end

  context "Set conditional and loops mixed" do
    it "Set conditionals and loops" do
      conditionalOne = Languages::ConditionalData.new
      conditionalOne.type = Languages::IF_LABEL
      conditionalTwo = Languages::ConditionalData.new
      conditionalTwo.type = Languages::ELSIF_LABEL

      repetitionOne = Languages::RepetitionData.new
      repetitionOne.type = Languages::FOR_LABEL
      repetitionTwo = Languages::RepetitionData.new
      repetitionTwo.type = Languages::WHILE_LABEL

      @functionAbstract.add_conditional(conditionalOne)
      @functionAbstract.add_repetition(repetitionOne, Languages::DOWN_LEVEL)
      @functionAbstract.add_conditional(conditionalTwo, Languages::UP_LEVEL)
      @functionAbstract.add_repetition(repetitionTwo, Languages::DOWN_LEVEL)

      all = @functionAbstract.managerCondLoopAndBlock.basicStructure
      expect(all[0].level).to eq(0)
      expect(all[1].level).to eq(1)
      expect(all[1].type).to eq(Languages::FOR_LABEL)
      expect(all[2].level).to eq(0)
      expect(all[3].level).to eq(1)
      expect(all[3].type).to eq(Languages::WHILE_LABEL)
    end

    it "Set loops and conditionals" do
      conditionalOne = Languages::ConditionalData.new
      conditionalOne.type = Languages::IF_LABEL
      conditionalTwo = Languages::ConditionalData.new
      conditionalTwo.type = Languages::ELSIF_LABEL

      repetitionOne = Languages::RepetitionData.new
      repetitionOne.type = Languages::FOR_LABEL
      repetitionTwo = Languages::RepetitionData.new
      repetitionTwo.type = Languages::WHILE_LABEL

      @functionAbstract.add_repetition(repetitionOne)
      @functionAbstract.add_repetition(repetitionTwo, Languages::DOWN_LEVEL)
      @functionAbstract.add_conditional(conditionalOne, Languages::DOWN_LEVEL)
      @functionAbstract.add_conditional(conditionalTwo)

      all = @functionAbstract.managerCondLoopAndBlock.basicStructure
      expect(all[0].level).to eq(0)
      expect(all[0].type).to eq(Languages::FOR_LABEL)
      expect(all[1].level).to eq(1)
      expect(all[1].type).to eq(Languages::WHILE_LABEL)
      expect(all[2].level).to eq(2)
      expect(all[2].type).to eq(Languages::IF_LABEL)
      expect(all[3].level).to eq(2)
      expect(all[3].type).to eq(Languages::ELSIF_LABEL)

    end

  end

  context "When instantiating" do
    it "Does not set name" do
      @functionAbstract = Languages::FunctionAbstract.new(nil)
      expect(@functionAbstract.name).to be_nil
      @functionAbstract = Languages::FunctionAbstract.new(1)
      expect(@functionAbstract.name).to be_nil
    end
  end

  after :each do
    @functionAbstract = nil
    @conditional = nil
    @repetition = nil
  end

end
