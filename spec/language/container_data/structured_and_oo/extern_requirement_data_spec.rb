require_relative '../../../spec_helper'

RSpec.describe Languages::ExternRequirementData do

  before :all do
    @externRequirement = Languages::ExternRequirementData.new("xpto")
  end

  context "Using constructor to create data container." do
    it "Create container" do
      expect(@externRequirement.name).to eq("xpto")
    end
    it "Get argument error" do
      expect{Languages::ExternRequirementData.new(nil)}.to raise_error(ArgumentError)
      expect{Languages::ExternRequirementData.new(1)}.to raise_error(ArgumentError)
    end
  end

  context "When set path" do
    it "Set path." do
      @externRequirement.setPath("spec/samples/emptyFile")
      expect(@externRequirement.path).to eq("spec/samples/emptyFile")
    end
    it "Get argument error" do
      expect{@externRequirement.setPath(nil)}.to raise_error(ArgumentError)
      expect{@externRequirement.setPath(1)}.to raise_error(ArgumentError)
      expect{@externRequirement.setPath("non-file")}.to raise_error(ArgumentError)
    end
  end

  after :all do
    @externRequirement = nil
  end

end
