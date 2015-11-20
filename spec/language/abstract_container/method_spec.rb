require_relative '../../spec_helper'

RSpec.describe Languages::Method do

  context "When not implemented" do
    it "Get method" do
      methodAbstract = Languages::Method.new
      expect{methodAbstract.get_method("xpto")}.to raise_error(
              NotImplementedError)
    end
  end

end
