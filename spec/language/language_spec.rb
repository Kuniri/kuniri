require_relative '../spec_helper'

RSpec.describe Languages::Language do

  before :each do
    @abstractLanguage = Languages::Language.new
  end

  context 'When try to call analyse_source' do
    it "Try to call unimplemented method." do
      expect{@abstractLanguage.analyse_source}.to raise_error(
        NotImplementedError)
    end
  end

  context "Handling nested conditional and repetitions" do
    it "Make it more nested" do
      expect(@abstractLanguage.countNestedCondLoop).to eq(0)
      @abstractLanguage.moreNested
      expect(@abstractLanguage.countNestedCondLoop).to eq(1)
      @abstractLanguage.moreNested
      expect(@abstractLanguage.countNestedCondLoop).to eq(2)
    end

    it "Make it less nested" do
      expect(@abstractLanguage.countNestedCondLoop).to eq(0)
      @abstractLanguage.moreNested
      @abstractLanguage.moreNested
      @abstractLanguage.moreNested
      expect(@abstractLanguage.countNestedCondLoop).to eq(3)
      @abstractLanguage.lessNested
      expect(@abstractLanguage.countNestedCondLoop).to eq(2)
      @abstractLanguage.lessNested
      expect(@abstractLanguage.countNestedCondLoop).to eq(1)
    end

    it "Can't have negative nested" do
      @abstractLanguage.lessNested
      @abstractLanguage.lessNested
      @abstractLanguage.lessNested
      @abstractLanguage.lessNested
      expect(@abstractLanguage.countNestedCondLoop).to eq(0)
    end

    it "Have to be nested" do
      @abstractLanguage.moreNested
      expect(@abstractLanguage.isNested?).to eq(true)
    end

    it "Not nested" do
      @abstractLanguage.moreNested
      expect(@abstractLanguage.isNested?).to eq(true)
      @abstractLanguage.lessNested
      expect(@abstractLanguage.isNested?).to eq(false)
    end

    it "Reset nested" do
      @abstractLanguage.moreNested
      expect(@abstractLanguage.countNestedCondLoop).to eq(1)
      @abstractLanguage.resetNested
      expect(@abstractLanguage.countNestedCondLoop).to eq(0)
    end
  end

  context 'Verify line_inpect' do
    it 'check method object' do
      expect{@abstractLanguage.line_inspect(StateMachine::METHOD_ID, 'something')}.to raise_error(
              NoMethodError)
    end
  end

  after :each do
    @abstractLanguage = nil
  end

end
