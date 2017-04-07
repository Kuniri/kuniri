require_relative '../../spec_helper'

RSpec.describe Languages::EndBlock do

  context "When not implemented" do
    it "Has end of block?" do
      endAbstract = Languages::EndBlock.new
      expect{endAbstract.end_of_block?("end")}.to raise_error(
              NotImplementedError)
    end
  end


end
