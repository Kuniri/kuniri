require_relative '../../spec_helper'

RSpec.describe Languages::Class do

  context "When not implemented" do
    it "Get class" do
      classAbstract = Languages::Class.new
      #expect(classAbstract.get_class("nothing")).to raise_error(
      #        NotImplementedError)
    end
  end

end
