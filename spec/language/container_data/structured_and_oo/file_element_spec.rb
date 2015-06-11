require_relative '../../../spec_helper'

RSpec.describe Languages::FileElement do

  before :each do
    @fileElement = Languages::FileElement.new ("test")
    @globalFunction1 = Languages::FunctionData.new("xpto")
    @globalFunction2 = Languages::FunctionData.new("second")
    @globalVariable1 = [Languages::VariableGlobalData.new("var1")]
    @globalVariable2 = [Languages::VariableGlobalData.new("var2")]
    @externFile1 = Languages::ExternRequirementData.new ("/dir/1")
    @externFile2 = Languages::ExternRequirementData.new ("/dir/2")
    @class1 = Languages::ClassData.new
  end

  context "When add global function." do

    it "Add one global function" do
      @fileElement.add_global_function(@globalFunction1)
      expect(@fileElement.global_functions[0].name == "xpto").to be true
    end

    it "Add two global functions" do
      @fileElement.add_global_function(@globalFunction1)
      @fileElement.add_global_function(@globalFunction2)
      functionName = []
      @fileElement.global_functions.each do |function|
        functionName.push(function.name)
      end
      expect(functionName).to match_array(["xpto", "second"])
    end

    it "Add Non function data" do
      @fileElement.add_global_function("xpto")
      expect(@fileElement.global_functions).to match_array([])
    end

  end

  context "When add global variable." do

    it "Add one global variable." do
      @fileElement.add_global_variable(@globalVariable1)
      expect(@fileElement.global_variables[0].name == "var1").to be true
    end

    it "Add two global variable." do
      @fileElement.add_global_variable(@globalVariable1)
      @fileElement.add_global_variable(@globalVariable2)
      variables = []
      @fileElement.global_variables.each do |variable|
        variables.push(variable.name)
      end
      expect(variables).to match_array(["var1", "var2"])
    end

    it "Add non global variable." do
      @fileElement.add_global_variable(["xpto"])
      expect(@fileElement.global_variables).to match_array([])
    end

  end

  context "When add external files." do
    it "Add one external element." do
      @fileElement.add_extern_requirement(@externFile1)
      expect(@fileElement.extern_requirements[0].name == "/dir/1").to be true
    end

    it "Add two external elements." do
      @fileElement.add_extern_requirement(@externFile1)
      @fileElement.add_extern_requirement(@externFile2)
      extern = []
      @fileElement.extern_requirements.each do |externs|
        extern.push(externs.name)
      end
      expect(extern).to match_array(["/dir/1", "/dir/2"])
    end

    it "Add non extern requirement." do
      @fileElement.add_extern_requirement("xpto")
      expect(@fileElement.extern_requirements).to match_array([])
    end

  end

  after :each do
    @fileElement = nil
  end

end 
