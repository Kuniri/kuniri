require_relative '../../../spec_helper'

RSpec.describe Languages::ExternRequirementData do

  before :all do
    @externRequirement = Languages::ExternRequirementData.new("xpto")
  end

  context "Using constructor to create data container." do
    it "Create container" do
      expect(@externRequirement.name).to eq("xpto")
    end
    it "Does not set name" do
      @externRequirement = Languages::ExternRequirementData.new(nil)
      expect(@externRequirement.name).to be_nil
      @externRequirement = Languages::ExternRequirementData.new(1)
      expect(@externRequirement.name).to be_nil
    end
  end

  context "When set library" do
    it "Set library." do
      @externRequirement.setLibrary("spec/samples/emptyFile")
      expect(@externRequirement.library).to eq("spec/samples/emptyFile")
    end
    it "Does not set library" do
      @externRequirement = Languages::ExternRequirementData.new("xpto")
      @externRequirement.setLibrary(1)
      expect(@externRequirement.library).to be_nil
      @externRequirement.setLibrary(nil)
      expect(@externRequirement.library).to be_nil
      @externRequirement.setLibrary("")
      expect(@externRequirement.library).to be_nil
    end
  end

  after :all do
    @externRequirement = nil
  end

end
