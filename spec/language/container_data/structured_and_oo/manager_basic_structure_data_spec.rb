require_relative '../../../spec_helper'

RSpec.describe Languages::ManagerBasicStructureData do

  before :each do
    @manager = Languages::ManagerBasicStructureData.new
  end

  context "Simple conditionals" do
    it "Add simple if." do
      conditional = Languages::ConditionalData.new
      conditional.type = Languages::IF_LABEL

      @manager.add_conditional(conditional)
      expect(@manager.basicStructure[0]).to eq(conditional)
    end

    it "Add simple if and elsif." do
      conditional = Languages::ConditionalData.new
      conditional.type = Languages::IF_LABEL
      elsifConditional = Languages::ConditionalData.new
      elsifConditional.type = Languages::ELSIF_LABEL

      @manager.add_conditional(conditional)
      @manager.add_conditional(elsifConditional)

      expect(@manager.basicStructure[0].type).to eq(Languages::IF_LABEL)
      expect(@manager.basicStructure[1].type).to eq(Languages::ELSIF_LABEL)
    end

    it "Add a sequence of if, elsif and finish with else." do
      conditional1 = Languages::ConditionalData.new
      conditional1.type = Languages::IF_LABEL
      elsifConditional1 = Languages::ConditionalData.new
      elsifConditional1.type = Languages::ELSIF_LABEL
      elsifConditional2 = Languages::ConditionalData.new
      elsifConditional2.type = Languages::ELSIF_LABEL
      elseConditional3 = Languages::ConditionalData.new
      elseConditional3.type = Languages::ELSE_LABEL

      @manager.add_conditional(conditional1)
      @manager.add_conditional(elsifConditional1)
      @manager.add_conditional(elsifConditional2)
      @manager.add_conditional(elseConditional3)

      expect(@manager.basicStructure[0].type).to eq(Languages::IF_LABEL)
      expect(@manager.basicStructure[1].type).to eq(Languages::ELSIF_LABEL)
      expect(@manager.basicStructure[2].type).to eq(Languages::ELSIF_LABEL)
      expect(@manager.basicStructure[3].type).to eq(Languages::ELSE_LABEL)
    end
  end

  context "Simple repetitions." do
    it "Simple repetition." do
      repetition = Languages::RepetitionData.new
      repetition.type = Languages::WHILE_LABEL
      @manager.add_repetition(repetition)
      expect(@manager.basicStructure[0].type).to eq(Languages::WHILE_LABEL)
    end
  end

  context "Nested conditionals." do
    it "Basic if nested, level 1." do
      conditional1 = Languages::ConditionalData.new
      conditional1.type = Languages::IF_LABEL
      conditional2 = Languages::ConditionalData.new
      conditional2.type = Languages::IF_LABEL
      conditional3 = Languages::ConditionalData.new
      conditional3.type = Languages::IF_LABEL

      @manager.add_conditional(conditional1)
      @manager.increase_deep_level
      @manager.add_conditional(conditional2)
      @manager.add_conditional(conditional3)

      expect(@manager.basicStructure[0].level).to eq(0)
      expect(@manager.basicStructure[1].level).to eq(1)
      expect(@manager.basicStructure[2].level).to eq(1)
    end

    it "Basic nested if with elsif, level 1." do
      conditional1 = Languages::ConditionalData.new
      conditional1.type = Languages::IF_LABEL
      conditional2 = Languages::ConditionalData.new
      conditional2.type = Languages::ELSIF_LABEL

      conditional3 = Languages::ConditionalData.new
      conditional3.type = Languages::IF_LABEL
      conditional4 = Languages::ConditionalData.new
      conditional4.type = Languages::IF_LABEL
      conditional5 = Languages::ConditionalData.new
      conditional5.type = Languages::IF_LABEL

      @manager.add_conditional(conditional1)
      @manager.increase_deep_level
      @manager.add_conditional(conditional3)
      @manager.add_conditional(conditional4)
      @manager.decrease_deep_level
      @manager.add_conditional(conditional2)
      @manager.increase_deep_level
      @manager.add_conditional(conditional5)

      expect(@manager.basicStructure[0].level).to eq(0)
      expect(@manager.basicStructure[1].level).to eq(1)
      expect(@manager.basicStructure[2].level).to eq(1)
      expect(@manager.basicStructure[3].level).to eq(0)
      expect(@manager.basicStructure[4].level).to eq(1)
    end

  end

  context "Nested repetitions." do
    it "Simple repetition." do
      repetition1 = Languages::RepetitionData.new
      repetition1.type = Languages::WHILE_LABEL

      repetition2 = Languages::RepetitionData.new
      repetition2.type = Languages::WHILE_LABEL

      @manager.add_repetition(repetition1)
      @manager.increase_deep_level
      @manager.add_repetition(repetition2)

      expect(@manager.basicStructure[0].level).to eq(0)
      expect(@manager.basicStructure[1].level).to eq(1)
    end
  end

  context "Nested conditionals and repetitions." do
    it "Simple conditional with repetition." do
      repetition1 = Languages::RepetitionData.new
      repetition1.type = Languages::WHILE_LABEL

      conditional1 = Languages::ConditionalData.new
      conditional1.type = Languages::IF_LABEL

      @manager.add_conditional(conditional1)
      @manager.increase_deep_level
      @manager.add_repetition(repetition1)

      expect(@manager.basicStructure[0].level).to eq(0)
      expect(@manager.basicStructure[1].level).to eq(1)
    end
  end

  context "Simple block" do
    it "Simple block." do
      block = Languages::BlockData.new
      block.type = Languages::BLOCK_LABEL
      @manager.add_block(block)
      expect(@manager.basicStructure[0].type).to eq(Languages::BLOCK_LABEL)
    end
  end

  context "Nested blocks." do
    it "Simple blocks." do
      block1 = Languages::BlockData.new
      block1.type = Languages::BLOCK_LABEL

      block2 = Languages::BlockData.new
      block2.type = Languages::BLOCK_LABEL

      @manager.add_block(block1)
      @manager.increase_deep_level
      @manager.add_block(block2)

      expect(@manager.basicStructure[0].level).to eq(0)
      expect(@manager.basicStructure[1].level).to eq(1)
    end
  end

  after :each do
    @manager = nil
  end
end

