require_relative '../../../spec_helper'

RSpec.describe Languages::FunctionAbstract do

  before :each do
    @functionAbstract = Languages::FunctionAbstract.new "Teste"
  end

  context "When adding a parameter" do
    it "adds a parameter" do
      @functionAbstract.add_parameters("a")
      expect(@functionAbstract.parameters).to eq(["a"])
    end

    it "adds a parameter with assignment" do
      @functionAbstract.add_parameters({"key" => "a"})
      expect(@functionAbstract.parameters).to eq([{"key" => "a"}])
    end

    it "adds multiple parameters" do
      @functionAbstract.add_parameters("a")
      @functionAbstract.add_parameters("b")
      @functionAbstract.add_parameters("c")
      expect(@functionAbstract.parameters).to eq(["a", "b", "c"])
    end

    it "adds multiple parameters with assignment" do
      @functionAbstract.add_parameters({"key1" => "a"})
      @functionAbstract.add_parameters({"key2" => "b"})
      @functionAbstract.add_parameters({"key3" => "c"})
      expect(@functionAbstract.parameters).to eq([{"key1" => "a"}, {"key2" => "b"}, {"key3" => "c"}])
    end

    it "adds an integer as a parameter" do
      @functionAbstract.add_parameters(12)
      expect(@functionAbstract.parameters).to_not eq([12])
    end

    it "adds a hash with more than one element as a parameter" do
      @functionAbstract.add_parameters({"key1" => "a", "key2" => "b"})
      expect(@functionAbstract.parameters).to_not eq([{"key1" => "a", "key2" => "b"}])
    end

  end

  after :each do
    @functionAbstract = nil
  end

end 
