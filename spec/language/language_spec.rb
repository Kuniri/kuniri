require_relative '../spec_helper'

RSpec.describe Languages::Language do

  before :all do
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

  after :all do
    @abstractLanguage = nil
  end

end
