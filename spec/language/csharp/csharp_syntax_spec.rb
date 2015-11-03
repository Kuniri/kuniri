require_relative '../../spec_helper'

RSpec.describe Languages::CsharpSyntax do

  before :each do
    @syntax = Languages::CsharpSyntax.new
  end

  context "Extern requirement detections." do

    it "Correct state transition." do
      path = "spec/samples/csharpSyntaxParts/extern/simpleExternRequirement.cs"

      expect(@syntax.state)
          .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
      @syntax.analyse_source(path)
      expect(@syntax.state)
          .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
    end

    it "Correct data capture." do
      path = "spec/samples/csharpSyntaxParts/extern/simpleExternRequirement.cs"

      @syntax.analyse_source(path)
      expect(@syntax.fileElements[0].extern_requirements[0].name).to eq ("one")
      expect(@syntax.fileElements[0].extern_requirements[1].name).to eq ("two")
      expect(@syntax.fileElements[0].extern_requirements[2].name)
        .to eq ("three")
      expect(@syntax.fileElements[0].extern_requirements[3].name)
        .to eq ("four")
      expect(@syntax.fileElements[0].extern_requirements[4].name)
        .to eq ("five")
      expect(@syntax.fileElements[0].extern_requirements[5].name).to eq ("six")
      expect(@syntax.fileElements[0].extern_requirements[6].name)
        .to eq ("seven")
      expect(@syntax.fileElements[0].extern_requirements[7].name)
        .to eq ("eight")
      expect(@syntax.fileElements[0].extern_requirements[8].name)
        .to eq ("nine")
      expect(@syntax.fileElements[0].extern_requirements.size).to eq (9)
    end

  end
  
  context "Global function" do
    it "Correct state transition function." do
      path = "spec/samples/csharpSyntaxParts/function/simpleFunction.cs"
      expect(@syntax.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
      @syntax.analyse_source(path)
      expect(@syntax.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
    end

    it "Correct data capture (global function)" do
      path = "spec/samples/csharpSyntaxParts/function/simpleFunction.cs"

      @syntax.analyse_source(path)
      expect(@syntax.fileElements[0].global_functions[0].name)
        .to eq("simpleFunction1")
      expect(@syntax.fileElements[0].global_functions[1].name)
        .to eq("simpleFunction2")
      expect(@syntax.fileElements[0].global_functions[2].name)
        .to eq("simpleFunction3")
      expect(@syntax.fileElements[0].global_functions[3].name)
        .to eq("simpleFunction4")
      expect(@syntax.fileElements[0].global_functions[4].name)
        .to eq("simpleFunction5")
      expect(@syntax.fileElements[0].global_functions[5].name)
        .to eq("simpleFunction6")
      expect(@syntax.fileElements[0].global_functions[6].name)
        .to eq("simpleFunction7")

    end
  end


  context "Class declaration" do
    it "Correct state transition." do
      path = "spec/samples/csharpSyntaxParts/class/simpleClass.cs"

      expect(@syntax.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
      @syntax.analyse_source(path)
      expect(@syntax.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
    end

    it "Correct data capture (class)." do
      path = "spec/samples/csharpSyntaxParts/class/simpleClass.cs"

      @syntax.analyse_source(path)
      expect(@syntax.fileElements[0].classes[0].name).to eq("Simple1")
      expect(@syntax.fileElements[0].classes[1].name).to eq("Simple2")
      expect(@syntax.fileElements[0].classes[2].name).to eq("Simple3")
      expect(@syntax.fileElements[0].classes[3].name).to eq("Simple4")
      expect(@syntax.fileElements[0].classes[4].name).to eq("Simple5")
    end

  end

  # context "Attribute line" do
  #   it "Correct state transition." do
  #     path = "spec/samples/csharpSyntaxParts/attribute/simpleAttribute.cs"

  #     expect(@syntax.state)
  #       .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
  #     @syntax.analyse_source(path)
  #     expect(@syntax.state)
  #       .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
  #   end

  #   it "Correct data capture (attribute)" do
  #     path = "spec/samples/csharpSyntaxParts/attribute/simpleAttribute.cs"

  #     @syntax.analyse_source(path)
  #     expect(@syntax.fileElements[0].classes[0].attributes[0].name)
  #       .to eq("attribute1")
  #     expect(@syntax.fileElements[0].classes[0].attributes[1].name)
  #       .to eq("attribute2")
  #     expect(@syntax.fileElements[0].classes[0].attributes[2].name)
  #       .to eq("attribute3")
  #     expect(@syntax.fileElements[0].classes[0].attributes[3].name)
  #       .to eq("attribute4")
  #     expect(@syntax.fileElements[0].classes[0].attributes[4].name)
  #       .to eq("attribute5")
  #     expect(@syntax.fileElements[0].classes[0].attributes[5].name)
  #       .to eq("attribute6")

  #   end
  # end

  context "Method line" do
    it "Correct state transition." do
      path = "spec/samples/csharpSyntaxParts/method/simpleMethod.cs"

      expect(@syntax.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
      @syntax.analyse_source(path)
      expect(@syntax.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
    end

    it "Correct data capture (method)" do
      path = "spec/samples/csharpSyntaxParts/method/simpleMethod.cs"

      @syntax.analyse_source(path)
      expect(@syntax.fileElements[0].classes[0].methods[0].name)
        .to eq("method1")
      expect(@syntax.fileElements[0].classes[0].methods[1].name)
        .to eq("method2")
      expect(@syntax.fileElements[0].classes[0].methods[2].name)
        .to eq("method3")
      expect(@syntax.fileElements[0].classes[0].methods[3].name)
        .to eq("method4")
      expect(@syntax.fileElements[0].classes[0].methods[4].name)
        .to eq("method5")
    end
  end

  context "Constructor line" do
    it "Correct state transition." do
      path = "spec/samples/csharpSyntaxParts/constructor/simpleConstructor.cs"

      expect(@syntax.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
        puts @syntax.state
        puts "*" * 30
      @syntax.analyse_source(path)
        puts @syntax.state
      expect(@syntax.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
    end

    it "Correct data capture (constructor)" do
      path = "spec/samples/csharpSyntaxParts/constructor/simpleConstructor.cs"

      @syntax.analyse_source(path)
      expect(@syntax.fileElements[0].classes[0].constructors[0].name)
        .to eq("Simple1")
      expect(@syntax.fileElements[0].classes[1].constructors[0].name)
        .to eq("Simple2")
    end
  end

  # context "Conditional line" do
  #   it "Correct state transition (Global function)." do
  #     path =
  #       "spec/samples/csharpSyntaxParts/conditionalStatment/simpleConditional.cs"

  #     expect(@syntax.state)
  #       .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
  #     @syntax.analyse_source(path)
  #     expect(@syntax.state)
  #       .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
  #   end

  #   it "Correct data capture (conditional - Global function)" do
  #      path =
  #       "spec/samples/csharpSyntaxParts/conditionalStatment/simpleConditional.cs"

  #     @syntax.analyse_source(path)
  #     expect(@syntax.fileElements[0].global_functions[0].name)
  #       .to eq("simple1")

  #     expect(@syntax.fileElements[0].global_functions[0]
  #           .conditionals[0].expression).to eq("3 > 2")
  #     expect(@syntax.fileElements[0].global_functions[0]
  #           .conditionals[0].type).to eq("IF")

  #     expect(@syntax.fileElements[0].global_functions[1].name)
  #       .to eq("simple2")
  #     expect(@syntax.fileElements[0].global_functions[1]
  #           .conditionals[0].expression).to eq("7 > 2")
  #     expect(@syntax.fileElements[0].global_functions[1]
  #           .conditionals[0].type).to eq("IF")

  #     expect(@syntax.fileElements[0].global_functions[1]
  #           .conditionals[1].expression).to eq("\"a\" < \"k\"")
  #     expect(@syntax.fileElements[0].global_functions[1]
  #           .conditionals[1].type).to eq("IF")
  #   end

  #   it "Correct state transition (Method)." do
  #     path =
  #       "spec/samples/csharpSyntaxParts/conditionalStatment/methodConditional.cs"

  #     expect(@syntax.state)
  #       .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
  #     @syntax.analyse_source(path)
  #     expect(@syntax.state)
  #       .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
  #   end

  #   it "Correct data capture (conditional - method)" do
  #      path =
  #       "spec/samples/csharpSyntaxParts/conditionalStatment/methodConditional.cs"

  #     @syntax.analyse_source(path)
  #     expect(@syntax.fileElements[0].classes[0].methods[0].name)
  #       .to eq("method1")

  #     expect(@syntax.fileElements[0].classes[0].methods[0].conditionals[0]
  #             .expression).to eq("x > 3")
  #     expect(@syntax.fileElements[0].classes[0].methods[0].conditionals[0]
  #             .type).to eq("IF")

  #     expect(@syntax.fileElements[0].classes[0].methods[1].name)
  #       .to eq("method2")
  #     expect(@syntax.fileElements[0].classes[0].methods[1].conditionals[0]
  #             .expression).to eq("b && c")
  #     expect(@syntax.fileElements[0].classes[0].methods[1].conditionals[0]
  #             .type).to eq("IF")

  #     expect(@syntax.fileElements[0].classes[0].methods[2].name)
  #       .to eq("method3")
  #     expect(@syntax.fileElements[0].classes[0].methods[2].conditionals[0]
  #             .expression).to eq("b == 3")
  #     expect(@syntax.fileElements[0].classes[0].methods[2].conditionals[1]
  #             .expression).to eq("b < 7")

  #     expect(@syntax.fileElements[0].classes[0].methods[2].conditionals[0]
  #             .type).to eq("IF")

  #     expect(@syntax.fileElements[0].classes[0].methods[3].name)
  #       .to eq("method4")
  #     expect(@syntax.fileElements[0].classes[0].methods[3].conditionals[0]
  #             .expression).to eq("x")
  #   end

  #   it "Correct state transition (Constructor)." do
  #     path = "spec/samples/csharpSyntaxParts/" +
  #             "conditionalStatment/constructorConditional.cs"

  #     expect(@syntax.state)
  #       .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
  #     @syntax.analyse_source(path)
  #     expect(@syntax.state)
  #       .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
  #   end

  #   it "Correct data capture (conditional - method)" do
  #      path = "spec/samples/csharpSyntaxParts/" +
  #               "conditionalStatment/constructorConditional.cs"

  #     @syntax.analyse_source(path)
  #     expect(@syntax.fileElements[0].classes[0].constructors[0].name)
  #         .to eq("initialize")

  #     expect(@syntax.fileElements[0].classes[0].constructors[0].conditionals[0]
  #             .expression).to eq("a > b")
  #     expect(@syntax.fileElements[0].classes[0].constructors[0].conditionals[0]
  #             .type).to eq("IF")

  #     expect(@syntax.fileElements[0].classes[0].constructors[0].conditionals[1]
  #             .expression).to eq("x")
  #     expect(@syntax.fileElements[0].classes[0].constructors[0].conditionals[1]
  #             .type).to eq("CASE")

  #     expect(@syntax.fileElements[0].classes[0].constructors[0].conditionals[2]
  #             .expression).to eq("u && y")
  #     expect(@syntax.fileElements[0].classes[0].constructors[0].conditionals[2]
  #             .type).to eq("IF")

  #     expect(@syntax.fileElements[0].classes[0].constructors[0].conditionals[3]
  #             .expression).to eq("u == 1")
  #     expect(@syntax.fileElements[0].classes[0].constructors[0].conditionals[3]
  #             .type).to eq("ELSIF")
  #   end

  #   it "Correct data capture (repetition[while] -  Method)" do
  #      path = "spec/samples/csharpSyntaxParts/repetition/simpleRepetition.cs"

  #     @syntax.analyse_source(path)
  #     expect(@syntax.fileElements[0].classes[0].methods[0].name)
  #         .to eq("simple1")

  #     expect(@syntax.fileElements[0].classes[0].methods[0].repetitions[0]
  #             .expression).to eq("i < num")
  #   end

  #   it "Correct data capture (repetiton[util] - Method)" do
  #     path = "spec/samples/csharpSyntaxParts/repetition/simpleRepetition.cs"

  #     @syntax.analyse_source(path)
  #     expect(@syntax.fileElements[0].classes[0].methods[1].name)
  #         .to eq("simple2")

  #     expect(@syntax.fileElements[0].classes[0].methods[1].repetitions[0]
  #             .expression).to eq("i > num")

  #   end

  #   it "Correct data capture (repetition[for] -  Method)" do
  #     path = "spec/samples/csharpSyntaxParts/repetition/simpleRepetition.cs"

  #     @syntax.analyse_source(path)
  #     expect(@syntax.fileElements[0].classes[0].methods[1].name)
  #         .to eq("simple2")

  #     expect(@syntax.fileElements[0].classes[0].methods[1].repetitions[1]
  #             .expression).to eq("i in 0..5")
  #   end

  # end

  # context "Comments" do

  #   it "Correct single line comment capture - Globals" do

  #     path = "spec/samples/csharpSyntaxParts/" +
  #             "comment/simple_single_line_comment_global.cs"

  #     @syntax.analyse_source(path)
  #     expect(@syntax.fileElements[0].comments).to eq(" First comment\n")
  #     expect(@syntax.fileElements[0].global_functions[0].comments)
  #             .to eq(" Comment 2\n")
  #     expect(@syntax.fileElements[0].global_functions[1].comments)
  #             .to eq(" Combo comment p1\n Combo comment p2\n")
  #     expect(@syntax.fileElements[0].global_variables[0].comments)
  #             .to eq(" Comment 4\n")
  #   end

  #   it "Correct single line comment capture - Class" do

  #     path = "spec/samples/csharpSyntaxParts/" +
  #             "comment/simple_single_line_comment_class.cs"

  #     @syntax.analyse_source(path)
  #     expect(@syntax.fileElements[0].classes[0].comments)
  #             .to eq(" Comment 1: class\n")
  #     expect(@syntax.fileElements[0].classes[0].constructors[0].comments)
  #             .to eq(" Comment 2: constructor\n")
  #     expect(@syntax.fileElements[0].classes[0].methods[0].comments)
  #             .to eq(" Comment 3: method\n")
  #     expect(@syntax.fileElements[0].classes[0].methods[1].comments)
  #             .to eq(" Comment 4: Combo 1\n Comment 5: "+
  #                     "Combo 2\n Comment 6: Combo 3; Combo 4\n")
  #     expect(@syntax.fileElements[0].classes[0].attributes[0].comments)
  #             .to eq (" Comment 7: Attribute\n")
  #   end

  #   it "Correct multiple line comment capture - Global" do

  #     path = "spec/samples/csharpSyntaxParts/" +
  #             "comment/simple_multiple_line_comment_global.cs"

  #     @syntax.analyse_source(path)
  #     expect(@syntax.fileElements[0].comments)
  #       .to eq("Comment 1:\nMultiple line.\n")
  #     expect(@syntax.fileElements[0].global_functions[0].comments)
  #             .to eq("Global Function\nnumber one\nmultiple line\n")
  #     expect(@syntax.fileElements[0].global_variables[0].comments)
  #             .to eq("global\n")
  #   end

  #   it "Correct multiple line comment capture - Class" do

  #     path = "spec/samples/csharpSyntaxParts/" +
  #             "comment/simple_multiple_line_comment_class.cs"

  #     @syntax.analyse_source(path)
  #     expect(@syntax.fileElements[0].classes[0].comments)
  #             .to eq("This is the\nfirst class\nof this file.\n")
  #     expect(@syntax.fileElements[0].classes[0].constructors[0].comments)
  #             .to eq("    Constructor\n    initialize\n")
  #     expect(@syntax.fileElements[0].classes[0].methods[0].comments)
  #             .to eq("    First method\n")
  #     expect(@syntax.fileElements[0].classes[0].methods[1].comments)
  #             .to eq("    methodTwo\n")
  #     expect(@syntax.fileElements[0].classes[0].methods[2].comments)
  #             .to eq("    method;Three\n")

  #   end

  # end

  after :each do
    @syntax = nil
  end

end
