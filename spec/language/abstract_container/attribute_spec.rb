require_relative '../../spec_helper'

RSpec.describe Languages::Attribute do

  context "When not implemented" do
    it "Get attribute" do
      attributeAbstract = Languages::Attribute.new
      expect{attributeAbstract.get_attribute("nothing")}.to raise_error(
              NotImplementedError)
    end
  end

end
