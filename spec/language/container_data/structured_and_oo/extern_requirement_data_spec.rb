require_relative '../../../spec_helper'

RSpec.describe Languages::ExternRequirementData do

  before :each do
    @externRequirement = Languages::ExternRequirementData.new("xpto")
  end

  context "Using constructor to create data container." do
    it "Create container" do
      expect(@externRequirement.library).to eq("xpto")
    end

    it "Does not set name" do
      @externRequirement = Languages::ExternRequirementData.new(nil)
      expect(@externRequirement.library).to be_nil
      @externRequirement = Languages::ExternRequirementData.new(1)
      expect(@externRequirement.library).to be_nil
    end
  end

  context "When set library" do
    it "Set library." do
      @externRequirement.set_library("spec/samples/emptyFile")
      expect(@externRequirement.library).to eq("spec/samples/emptyFile")
    end
  end

  context "When set path" do
    it "Set path." do
      @externRequirement.set_library("xpto")
      expect(@externRequirement.library).to eq("xpto")
    end

    it "Does not set library" do
      @externRequirement = Languages::ExternRequirementData.new("xpto")
      @externRequirement.set_library(1)
      expect(@externRequirement.library).to eq("xpto")
      @externRequirement.set_library(nil)
      expect(@externRequirement.library).to eq("xpto")
      @externRequirement.set_library("")
      expect(@externRequirement.library).to eq("xpto")
    end
  end

  after :each do
    @externRequirement = nil
  end

end
