require_relative '../../spec_helper'

RSpec.describe Languages::Ruby::ExternRequirementRuby do

	before :all do
		@extern = Languages::Ruby::ExternRequirementRuby.new
	end

	context "When is a simple requirement with ''." do
    it "with no whitespaces" do
      requirement = @extern.get_requirement("require_relative 'example'")
      expect(requirement.name).to eq("example")
    end

    it "with whitespaces" do
      requirement = @extern.get_requirement(" require_relative 'example'  ")
      expect(requirement.name).to eq("example")
      requirement = @extern.get_requirement(" require_relative   'example'  ")
      expect(requirement.name).to eq("example")
      requirement = @extern.get_requirement(" require_relative 'example'")
      expect(requirement.name).to eq("example")
      requirement = @extern.get_requirement("require_relative 'example'  ")
      expect(requirement.name).to eq("example")
    end
  end

  context "When is a simple requirement with double quote." do
    it "with no whitespaces" do
      requirement = @extern.get_requirement('require_relative "example"')
      expect(requirement.name).to eq("example")
    end

    it "with whitespaces" do
      requirement = @extern.get_requirement(' require_relative "example"  ')
      expect(requirement.name).to eq("example")
      requirement = @extern.get_requirement(' require_relative   "example"  ')
      expect(requirement.name).to eq("example")
      requirement = @extern.get_requirement(' require_relative "example"')
      expect(requirement.name).to eq("example")
      requirement = @extern.get_requirement('require_relative "example"  ')
      expect(requirement.name).to eq("example")
    end
  end

  context "When is a simple requirement with simple quote." do
    it "with no whitespaces" do
      requirement = @extern.get_requirement("require_relative 'example'")
      expect(requirement.name).to eq("example")
    end

    it "with whitespaces" do
      requirement = @extern.get_requirement(" require_relative 'example'  ")
      expect(requirement.name).to eq("example")
      requirement = @extern.get_requirement(" require_relative   'example'  ")
      expect(requirement.name).to eq("example")
      requirement = @extern.get_requirement(" require_relative 'example'")
      expect(requirement.name).to eq("example")
      requirement = @extern.get_requirement("require_relative 'example'  ")
      expect(requirement.name).to eq("example")
    end
  end

  context "require when is a simple requirement with ''." do
    it "with no whitespaces" do
      requirement = @extern.get_requirement("require 'example'")
      expect(requirement.name).to eq("example")
    end

    it "with whitespaces" do
      requirement = @extern.get_requirement(" require 'example'  ")
      expect(requirement.name).to eq("example")
      requirement = @extern.get_requirement(" require   'example'  ")
      expect(requirement.name).to eq("example")
      requirement = @extern.get_requirement(" require 'example'")
      expect(requirement.name).to eq("example")
      requirement = @extern.get_requirement("require 'example'  ")
      expect(requirement.name).to eq("example")
    end
  end

  context "require when is a simple requirement with double quote." do
    it "with no whitespaces" do
      requirement = @extern.get_requirement('require "example"')
      expect(requirement.name).to eq("example")
    end

    it "with whitespaces" do
      requirement = @extern.get_requirement(' require "example"  ')
      expect(requirement.name).to eq("example")
      requirement = @extern.get_requirement(' require   "example"  ')
      expect(requirement.name).to eq("example")
      requirement = @extern.get_requirement(' require "example"')
      expect(requirement.name).to eq("example")
      requirement = @extern.get_requirement('require "example"  ')
      expect(requirement.name).to eq("example")
    end
  end

  context "require when is a simple requirement with simple quote." do
    it "with no whitespaces" do
      requirement = @extern.get_requirement("require 'example'")
      expect(requirement.name).to eq("example")
    end

    it "with whitespaces" do
      requirement = @extern.get_requirement(" require 'example'  ")
      expect(requirement.name).to eq("example")
      requirement = @extern.get_requirement(" require   'example'  ")
      expect(requirement.name).to eq("example")
      requirement = @extern.get_requirement(" require 'example'")
      expect(requirement.name).to eq("example")
      requirement = @extern.get_requirement("require 'example'  ")
      expect(requirement.name).to eq("example")
    end
  end

  after :all do
    @extern = nil
  end

end