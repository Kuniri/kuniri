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

  context 'When try to call comment_extract' do
    it "Try to call comment_extract in abstract class." do
      expect{@abstractLanguage.comment_extract}.to raise_error(
        NotImplementedError)
    end
  end

  context 'When try to call method_extract' do
    it "Try to call method_extract" do
      expect{@abstractLanguage.method_extract}.to raise_error(
        NotImplementedError)
    end
  end

  context "When try to call class_extract" do
    it "Try to call class_extract" do
      expect{@abstractLanguage.class_extract}.to raise_error(
        NotImplementedError)
    end
  end

  context "When try to call attribute_extract" do
    it "Try to call attribute_extract" do
      expect{@abstractLanguage.attribute_extract}.to raise_error(
        NotImplementedError)
    end
  end

  context "When try to call global_variable_extract" do
    it "Try to call global_variable_extract." do
      expect{@abstractLanguage.global_variable_extract}.to raise_error(
        NotImplementedError)
    end
  end

  context "When try to call extern_requirement_extract" do
    it "Try to call extern_requirement_extract" do
      expect{@abstractLanguage.extern_requirement_extract}.to raise_error(
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

  after :each do
    @abstractLanguage = nil
  end

end
