require_relative '../../spec_helper'

RSpec.describe Languages::GlobalFunction do

  context "When not implemented" do
    it "Get global function" do
      globalFunctionAbstract = Languages::GlobalFunction.new
      expect{globalFunctionAbstract.get_global_function("xpto")}
              .to raise_error(NotImplementedError)
    end
  end

end
