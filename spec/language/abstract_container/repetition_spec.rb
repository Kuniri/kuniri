require_relative '../../spec_helper'

RSpec.describe Languages::Repetition do

  context "When not implemented" do
    it "Get repetition." do
      repetitionAbstract = Languages::Repetition.new
      expect{repetitionAbstract.get_repetition("do")}.to raise_error(
              NotImplementedError)
    end
  end

end
