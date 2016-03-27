require_relative '../../spec_helper'

RSpec.describe Languages::Block do

  context "When not implemented" do
    it "Get block" do
      blockAbstract = Languages::Block.new
      expect{blockAbstract.get_blocks("nothing")}.to raise_error(
              NotImplementedError)
    end
  end

end
