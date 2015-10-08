require_relative '../../spec_helper'

RSpec.describe Languages::Cplusplus::ConstructorCplusplus do

  before :all do
    @constructor = Languages::Cplusplus::ConstructorCplusplus.new
  end

  context "When constructor without parameter" do
    it "Simple declaration" do
      input = "Xpto::Xpto()"
      expect(@constructor.get_constructor(input).name)
             .to eq("Xpto")
    end

    it "With spaces in the begin" do
      input = "         Xpto::Xpto()"
      expect(@constructor.get_constructor(input).name)
             .to eq("Xpto")
    end

    it "With spaces in the begin and between initialize" do
      input = "        Xpto  ::   Xpto()"
      expect(@constructor.get_constructor(input).name)
             .to eq("Xpto")
    end

    it "With spaces in both sides" do
      input = "            Xpto  ::   Xpto()                  "
      expect(@constructor.get_constructor(input).name)
             .to eq("Xpto")
    end

    it "No constructor" do
      input = "Xpto::Xpto2()"
      expect(@constructor.get_constructor(input))
             .to eq(nil)
    end
  end

  after :all do
    @constructor = nil
  end

end
