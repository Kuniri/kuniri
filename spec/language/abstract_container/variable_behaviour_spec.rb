require_relative '../../spec_helper'

RSpec.describe Languages::VariableBehaviour do

  before :all do
    @variableBehaviour = Languages::VariableBehaviour.new('me')
  end

  context "Call common declaration" do
    it "Expect to raise error" do
      expect{@variableBehaviour.common_declaration('xpto = 5', /xpto = 5/)}.to raise_error
    end
  end

  after :all do
    @variableBehaviour = nil
  end

end
