require_relative '../../spec_helper'

RSpec.describe Languages::Cplusplus::ExternRequirementCplusplus do

  before :all do
    @extern = Languages::Cplusplus::ExternRequirementCplusplus.new
  end

  context "When is a simple requirement with <>." do
    it "with no whitespaces" do
      requirement = @extern.get_requirement("#include<iostream>")
      expect(requirement.name).to eq("iostream")
    end

    it "with whitespaces" do
      requirement = @extern.get_requirement(" #include<iostream>  ")
      expect(requirement.name).to eq("iostream")
      requirement = @extern.get_requirement(" #include   <iostream>  ")
      expect(requirement.name).to eq("iostream")
      requirement = @extern.get_requirement(" #include<iostream>")
      expect(requirement.name).to eq("iostream")
      requirement = @extern.get_requirement("#include<iostream>  ")
      expect(requirement.name).to eq("iostream")
    end
  end

  context "When is a simple requirement with double quote." do
    it "with no whitespaces" do
      requirement = @extern.get_requirement('#include"iostream"')
      expect(requirement.name).to eq("iostream")
    end

    it "with whitespaces" do
      requirement = @extern.get_requirement(' #include"iostream"  ')
      expect(requirement.name).to eq("iostream")
      requirement = @extern.get_requirement(' #include   "iostream"  ')
      expect(requirement.name).to eq("iostream")
      requirement = @extern.get_requirement(' #include"iostream"')
      expect(requirement.name).to eq("iostream")
      requirement = @extern.get_requirement('#include"iostream"  ')
      expect(requirement.name).to eq("iostream")
    end
  end

  context "When is a simple requirement with simple quote." do
    it "with no whitespaces" do
      requirement = @extern.get_requirement("#include'iostream'")
      expect(requirement.name).to eq("iostream")
    end

    it "with whitespaces" do
      requirement = @extern.get_requirement(" #include'iostream'  ")
      expect(requirement.name).to eq("iostream")
      requirement = @extern.get_requirement(" #include   'iostream'  ")
      expect(requirement.name).to eq("iostream")
      requirement = @extern.get_requirement(" #include'iostream'")
      expect(requirement.name).to eq("iostream")
      requirement = @extern.get_requirement("#include'iostream'  ")
      expect(requirement.name).to eq("iostream")
    end
  end

  after :all do
    @extern = nil
  end

end

