require_relative '../../../spec_helper'

RSpec.describe Languages::ExternRequirementData do

  before :all do
    @externRequirement = Languages::ExternRequirementData.new("xpto")
  end

  context "Using constructor to create data container." do
    it "Create container" do
      expect(@externRequirement.name).to eq("xpto")
    end
  end

  context "When set path" do
    it "Set path." do
      @externRequirement.setPath("xpto")
      expect(@externRequirement.name).to eq("xpto")
    end
  end 

  after :all do
    @externRequirement = nil
  end

end 
