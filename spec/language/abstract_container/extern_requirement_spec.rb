require_relative '../../spec_helper'

RSpec.describe Languages::ExternRequirement do

  context "When not implemented" do
    it "Get requirement" do
      externAbstract = Languages::ExternRequirement.new
      expect{externAbstract.get_requirement("nothing")}.to raise_error(
              NotImplementedError)
    end
  end

end
