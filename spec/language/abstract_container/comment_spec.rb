require_relative '../../spec_helper'

RSpec.describe Languages::Comment do

  before :all do
    @commentAbstract = Languages::Comment.new
  end

  context "When comment is not implemented" do
    it "Get comment" do
      expect{@commentAbstract.get_comment("# nothing")}.to raise_error(
              NotImplementedError)
    end

    it "Is single line comment?" do
      expect{@commentAbstract.single_line_comment?(" # Single line")}
              .to raise_error(NotImplementedError)
    end

    it "Is multiple line comment?" do
      expect{@commentAbstract.multiple_line_comment?("=begin")}
              .to raise_error(NotImplementedError)
    end

  end

  after :all do
    @commentAbstract = nil
  end

end
