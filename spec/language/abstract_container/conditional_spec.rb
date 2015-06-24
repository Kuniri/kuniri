require_relative '../../spec_helper'

RSpec.describe Languages::Conditional do

  context "When not implemented" do
    it "Get conditional." do
      conditionalAbstract = Languages::Conditional.new
      expect{conditionalAbstract.get_conditional("if x > y")}.to raise_error(
              NotImplementedError)
    end
  end

end
