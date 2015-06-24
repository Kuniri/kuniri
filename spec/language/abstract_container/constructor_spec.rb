require_relative '../../spec_helper'

RSpec.describe Languages::Constructor do

  context "When not implemented" do
    it "Get constructor" do
      constructorAbstract = Languages::Constructor.new
      expect{constructorAbstract.get_constructor("xpto")}.to raise_error(
              NotImplementedError)
    end
  end

end
