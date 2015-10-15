require_relative '../../spec_helper'

RSpec.describe Languages::Csharp::ExternRequirementCsharp do

  before :all do
    @extern_requirement = Languages::Csharp::ExternRequirementCsharp.new
  end

  context "When requirement" do
    it "Simple requirement import" do
      input = "using System.ComponentModel.DataAnnotations;"
      expect(@extern_requirement.get_requirement(input).name)
             .to eq("System.ComponentModel.DataAnnotations")
    end

    it "Simple requirement import with spaces in the end" do
      input = "using System.ComponentModel.DataAnnotations;      "
      expect(@extern_requirement.get_requirement(input).name)
             .to eq("System.ComponentModel.DataAnnotations")
    end

    it "Simple requirement import with spaces in the beginning" do
      input = "      using System.ComponentModel.DataAnnotations;"
      expect(@extern_requirement.get_requirement(input).name)
             .to eq("System.ComponentModel.DataAnnotations")
    end

    it "Simple requirement import with spaces in the beginning" do
      input = "      using System.ComponentModel.DataAnnotations;"
      expect(@extern_requirement.get_requirement(input).name)
             .to eq("System.ComponentModel.DataAnnotations")
    end

    it "Simple requirement import with spaces in the between" do
      input = "using         System.ComponentModel.DataAnnotations;"
      expect(@extern_requirement.get_requirement(input).name)
             .to eq("System.ComponentModel.DataAnnotations")
    end

     it "Simple requirement import with spaces in the random places" do
      input = "    using         System.ComponentModel.DataAnnotations;     "
      expect(@extern_requirement.get_requirement(input).name)
             .to eq("System.ComponentModel.DataAnnotations")
    end
  end

  after :all do
    @extern_requirement = nil
  end
end