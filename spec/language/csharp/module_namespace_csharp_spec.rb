require_relative '../../spec_helper'

RSpec.describe Languages::Csharp::ModuleNamespaceCsharp do

  before :all do
    @modules = Languages::Csharp::ModuleNamespaceCsharp.new
  end
  
  context "Common case of module declarations" do
    it "Module on corner." do
      capturedModule = @modules.
                       get_module("namespace Mvc3ToolsUpdateWeb_Default.Models")
      expect(capturedModule.name).to eq("Mvc3ToolsUpdateWeb_Default.Models")
    end

    it "Module with space before." do
      capturedModule = @modules.get_module("     namespace Xpto")
      expect(capturedModule.name).to eq("Xpto")
    end

    it "Module with space after." do
      capturedModule = @modules.get_module("namespace TestOne       ")
      expect(capturedModule.name).to eq("TestOne")
    end

    it "Module with space after, and before." do
      capturedModule = @modules.get_module("     namespace BeforeAfter      ")
      expect(capturedModule.name).to eq("BeforeAfter")
    end

    it "Module with space between keyword and name." do
      capturedModule = @modules.get_module("namespace       SpaceBetween")
      expect(capturedModule.name).to eq("SpaceBetween")
    end

    it "Module with space between keyword, and before." do
      capturedModule = 
        @modules.get_module("     namespace     SpaceBetweenBefore")
      expect(capturedModule.name).to eq("SpaceBetweenBefore")
    end

    it "Module with space before keyword, and after." do
      capturedModule = @modules.get_module("namespace    SpaceBetweenAfter    ")
      expect(capturedModule.name).to eq("SpaceBetweenAfter")
    end

    it "Module with space before keyword, between, and after" do
      capturedModule = @modules.get_module("   namespace  BeforeBetweenAfter  ")
      expect(capturedModule.name).to eq("BeforeBetweenAfter")
    end
  end

  after :all do
    @module = nil
  end
end
