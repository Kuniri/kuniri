require_relative '../../spec_helper'

RSpec.describe Languages::Ruby::ModuleNamespaceRuby do

  before :all do
    @modules = Languages::Ruby::ModuleNamespaceRuby.new
  end
  
  context "Common case of module declarations" do
    it "Module on corner." do
      capturedModule = @module.get_module("module Abc")
      expect(moduleCaptured.name).to eq("Abc")
    end

    it "Module with space before." do
      capturedModule = @module.get_module("     module Xpto")
      expect(capturedModule.name).to eq("Xpto")
    end

    it "Module with space after." do
      capturedModule = @module.get_module("module TestOne       ")
      expect(capturedModule.name).to eq("TestOne")
    end

    it "Module with space after, and before." do
      capturedModule = @module.get_module("     module BeforeAfter      ")
      expect(capturedModule.name).to eq("BeforeAfter")
    end

    it "Module with space between keyword and name." do
      capturedModule = @module.get_module("module       SpaceBetween")
      expect(capturedModule.name).to eq("SpaceBetween")
    end

    it "Module with space between keyword, and before." do
      capturedModule = @module.get_module("     module     SpaceBetweenBefore")
      expect(capturedModule.name).to eq("SpaceBetweenBefore")
    end

    it "Module with space before keyword, and after." do
      capturedModule = @module.get_module("module    SpaceBetweenAfter      ")
      expect(capturedModule.name).to eq("SpaceBetweenAfter")
    end

    it "Module with space before keyword, between, and after" do
      capturedModule = @module.get_module("     module  BeforeBetweenAfter  ")
      expect(capturedModule.name).to eq("BeforeBetweenAfter")
    end
  end

  after :all do
    @module = nil
  end
end
