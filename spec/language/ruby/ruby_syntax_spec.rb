require_relative '../../spec_helper'

RSpec.describe Languages::RubySyntax do

  before :each do
    @syntax = Languages::RubySyntax.new
    @syntax.metadata.allClasses.clear
    @syntax.metadata.allAggregations.clear
  end

  def openFile(file)
    fileElement = Languages::FileElementData.new(file)
    source = File.open(file, 'rb')
    return [fileElement, source]
  end

  context 'Extern requirement detections.' do

    it 'Correct state transition (require_relative).' do
      path = 'spec/samples/rubySyntaxParts/extern/requireRelative.rb'

      expect(@syntax.state)
          .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)

      instances = openFile(path)
      @syntax.analyse_source(instances[0], instances[1])

      expect(@syntax.state)
          .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
    end

    it 'Correct data capture (require_relative).' do
      path = 'spec/samples/rubySyntaxParts/extern/requireRelative.rb'

      instances = openFile(path)
      @syntax.analyse_source(instances[0], instances[1])
      expect(@syntax.fileElements[0].extern_requirements[0].library).to eq ('one')
      expect(@syntax.fileElements[0].extern_requirements[1].library).to eq ('two')
      expect(@syntax.fileElements[0].extern_requirements[2].library)
        .to eq ('three')
      expect(@syntax.fileElements[0].extern_requirements[3].library)
        .to eq ('four')
      expect(@syntax.fileElements[0].extern_requirements[4].library)
        .to eq ('five')
      expect(@syntax.fileElements[0].extern_requirements[5].library).to eq ('six')
      expect(@syntax.fileElements[0].extern_requirements.size).to eq (6)
    end

    it 'Correct state transition (require).' do
      path = 'spec/samples/rubySyntaxParts/extern/simpleExternRequirement.rb'

      expect(@syntax.state)
          .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
      instances = openFile(path)
      @syntax.analyse_source(instances[0], instances[1])

      expect(@syntax.state)
          .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
    end

    it 'Correct data capture (require).' do
      path = 'spec/samples/rubySyntaxParts/extern/simpleExternRequirement.rb'

      instances = openFile(path)
      @syntax.analyse_source(instances[0], instances[1])

      expect(@syntax.fileElements[0].extern_requirements[0].library).to eq ('one')
      expect(@syntax.fileElements[0].extern_requirements[1].library).to eq ('two')
      expect(@syntax.fileElements[0].extern_requirements[2].library)
        .to eq ('three')
      expect(@syntax.fileElements[0].extern_requirements[3].library)
        .to eq ('four')
      expect(@syntax.fileElements[0].extern_requirements[4].library)
        .to eq ('five')
      expect(@syntax.fileElements[0].extern_requirements[5].library).to eq ('six')
      expect(@syntax.fileElements[0].extern_requirements[6].library)
        .to eq ('seven')
      expect(@syntax.fileElements[0].extern_requirements[7].library)
        .to eq ('eight')
      expect(@syntax.fileElements[0].extern_requirements[8].library)
        .to eq ('nine')
      expect(@syntax.fileElements[0].extern_requirements.size).to eq (9)
    end

  end

  context 'Global variable declarations.' do
    it 'Correct state transition' do
      path = 'spec/samples/rubySyntaxParts/variable/simpleVariable.rb'
      expect(@syntax.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
      instances = openFile(path)
      @syntax.analyse_source(instances[0], instances[1])

      expect(@syntax.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
    end

    it 'Correct data capture (global variable).' do
      path = 'spec/samples/rubySyntaxParts/variable/simpleVariable.rb'

      instances = openFile(path)
      @syntax.analyse_source(instances[0], instances[1])

      expect(@syntax.fileElements[0].global_variables[0].name).to eq('one')
      expect(@syntax.fileElements[0].global_variables[1].name).to eq('two')
      expect(@syntax.fileElements[0].global_variables[2].name).to eq('three')
      expect(@syntax.fileElements[0].global_variables[3].name).to eq('four')
      expect(@syntax.fileElements[0].global_variables[4].name).to eq('five')
      expect(@syntax.fileElements[0].global_variables[5].name).to eq('six')
      expect(@syntax.fileElements[0].global_variables[6].name).to eq('seven')
      expect(@syntax.fileElements[0].global_variables[7].name).to eq('eight')
    end
  end

  context 'Global function' do
    it 'Correct state transition function.' do
      path = 'spec/samples/rubySyntaxParts/function/simpleFunction.rb'
      expect(@syntax.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
      instances = openFile(path)
      @syntax.analyse_source(instances[0], instances[1])

      expect(@syntax.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
    end

    it 'Correct data capture (global function)' do
      path = 'spec/samples/rubySyntaxParts/function/simpleFunction.rb'

      instances = openFile(path)
      @syntax.analyse_source(instances[0], instances[1])

      expect(@syntax.fileElements[0].global_functions[0].name)
        .to eq('simpleFunction1')
      expect(@syntax.fileElements[0].global_functions[1].name)
        .to eq('simpleFunction2')
      expect(@syntax.fileElements[0].global_functions[2].name)
        .to eq('simpleFunction3')
      expect(@syntax.fileElements[0].global_functions[3].name)
        .to eq('simpleFunction4')
      expect(@syntax.fileElements[0].global_functions[4].name)
        .to eq('simpleFunction5')
      expect(@syntax.fileElements[0].global_functions[5].name)
        .to eq('simpleFunction6')
      expect(@syntax.fileElements[0].global_functions[6].name)
        .to eq('simpleFunction7')
    end
  end

  context 'Module declaration.' do
    it 'Correct state transition.' do
      path = 'spec/samples/rubySyntaxParts/module/simpleModule.rb'
      expect(@syntax.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
      instances = openFile(path)
      @syntax.analyse_source(instances[0], instances[1])

      expect(@syntax.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
    end

    it 'Correct data capture (module)' do
      path = 'spec/samples/rubySyntaxParts/module/simpleModule.rb'

      instances = openFile(path)
      @syntax.analyse_source(instances[0], instances[1])

      expect(@syntax.fileElements[0].modules[0].name)
        .to eq('Xpto')
      expect(@syntax.fileElements[0].modules[1].name)
        .to eq('Abc')
      expect(@syntax.fileElements[0].modules[2].name)
        .to eq('Simple')
    end
  end

  context 'Class declaration' do
    it 'Correct state transition.' do
      path = 'spec/samples/rubySyntaxParts/class/simpleClass.rb'

      expect(@syntax.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
      instances = openFile(path)
      @syntax.analyse_source(instances[0], instances[1])

      expect(@syntax.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
    end

    it 'Correct data capture (class).' do
      path = 'spec/samples/rubySyntaxParts/class/simpleClass.rb'

      instances = openFile(path)
      @syntax.analyse_source(instances[0], instances[1])

      expect(@syntax.fileElements[0].classes[0].name).to eq('Simple1')
      expect(@syntax.fileElements[0].classes[1].name).to eq('Simple2')
      expect(@syntax.fileElements[0].classes[2].name).to eq('Simple3')
      expect(@syntax.fileElements[0].classes[3].name).to eq('Simple4')
      expect(@syntax.fileElements[0].classes[4].name).to eq('Simple5')
    end

    it 'All classes in Metadata array' do
      path = 'spec/samples/rubySyntaxParts/class/simpleClass.rb'

      instances = openFile(path)
      @syntax.analyse_source(instances[0], instances[1])


      expect(@syntax.metadata.allClasses.size).to eq(5)
      expect(@syntax.metadata.allClasses[0].name).to eq('Simple1')
      expect(@syntax.metadata.allClasses[1].name).to eq('Simple2')
      expect(@syntax.metadata.allClasses[2].name).to eq('Simple3')
      expect(@syntax.metadata.allClasses[3].name).to eq('Simple4')
      expect(@syntax.metadata.allClasses[4].name).to eq('Simple5')
    end


  end

  context 'Attribute line' do
    it 'Correct state transition.' do
      path = 'spec/samples/rubySyntaxParts/attribute/simpleAttribute.rb'

      expect(@syntax.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
      instances = openFile(path)
      @syntax.analyse_source(instances[0], instances[1])

      expect(@syntax.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
    end

    it 'Correct data capture (attribute)' do
      path = 'spec/samples/rubySyntaxParts/attribute/simpleAttribute.rb'

      instances = openFile(path)
      @syntax.analyse_source(instances[0], instances[1])

      expect(@syntax.fileElements[0].classes[0].attributes[0].name)
        .to eq('attribute1')
      expect(@syntax.fileElements[0].classes[0].attributes[1].name)
        .to eq('attribute2')
      expect(@syntax.fileElements[0].classes[0].attributes[2].name)
        .to eq('attribute3')
      expect(@syntax.fileElements[0].classes[0].attributes[3].name)
        .to eq('attribute4')
      expect(@syntax.fileElements[0].classes[0].attributes[4].name)
        .to eq('attribute5')
      expect(@syntax.fileElements[0].classes[0].attributes[5].name)
        .to eq('attribute6')

    end
  end

  context 'Method line' do
    it 'Correct state transition.' do
      path = 'spec/samples/rubySyntaxParts/method/simpleMethod.rb'

      expect(@syntax.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
      instances = openFile(path)
      @syntax.analyse_source(instances[0], instances[1])

      expect(@syntax.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
    end

    it 'Correct data capture (method)' do
      path = 'spec/samples/rubySyntaxParts/method/simpleMethod.rb'

      instances = openFile(path)
      @syntax.analyse_source(instances[0], instances[1])

      expect(@syntax.fileElements[0].classes[0].methods[0].name)
        .to eq('method1')
      expect(@syntax.fileElements[0].classes[0].methods[1].name)
        .to eq('method2')
      expect(@syntax.fileElements[0].classes[0].methods[2].name)
        .to eq('method3')
      expect(@syntax.fileElements[0].classes[0].methods[3].name)
        .to eq('method4')
      expect(@syntax.fileElements[0].classes[0].methods[4].name)
        .to eq('method5')
    end
  end

  context 'Constructor line' do
    it 'Correct state transition.' do
      path = 'spec/samples/rubySyntaxParts/constructor/simpleConstructor.rb'

      expect(@syntax.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
      instances = openFile(path)
      @syntax.analyse_source(instances[0], instances[1])

      expect(@syntax.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
    end

    it 'Correct data capture (constructor)' do
      path = 'spec/samples/rubySyntaxParts/constructor/simpleConstructor.rb'

      instances = openFile(path)
      @syntax.analyse_source(instances[0], instances[1])

      expect(@syntax.fileElements[0].classes[0].constructors[0].name)
        .to eq('initialize')
      expect(@syntax.fileElements[0].classes[1].constructors[0].name)
        .to eq('initialize')
    end
  end

  context 'Conditional line' do
    it 'Correct state transition (Global function).' do
      path =
        'spec/samples/rubySyntaxParts/conditionalStatment/simpleConditional.rb'

      expect(@syntax.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
      instances = openFile(path)
      @syntax.analyse_source(instances[0], instances[1])

      expect(@syntax.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
    end

    it 'Correct data capture (conditional - Global function)' do
       path =
        'spec/samples/rubySyntaxParts/conditionalStatment/simpleConditional.rb'

      instances = openFile(path)
      @syntax.analyse_source(instances[0], instances[1])

      allFuntion0 = @syntax.fileElements[0].global_functions[0]
                                        .managerCondLoopAndBlock.basicStructure
      allFuntion1 = @syntax.fileElements[0].global_functions[1]
                                        .managerCondLoopAndBlock.basicStructure

      expect(@syntax.fileElements[0].global_functions[0].name).to eq('simple1')
      expect(allFuntion0[0].expression).to eq('3 > 2')
      expect(allFuntion0[0].type).to eq(Languages::IF_LABEL)

      expect(@syntax.fileElements[0].global_functions[1].name).to eq('simple2')
      expect(allFuntion1[0].expression).to eq('7 > 2')
      expect(allFuntion1[0].type).to eq(Languages::IF_LABEL)
      expect(allFuntion1[1].expression).to eq("\"a\" < \"k\"")
      expect(allFuntion1[1].type).to eq(Languages::IF_LABEL)
    end

    it 'Correct state transition (Method).' do
      path =
        'spec/samples/rubySyntaxParts/conditionalStatment/methodConditional.rb'

      expect(@syntax.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
      instances = openFile(path)
      @syntax.analyse_source(instances[0], instances[1])

      expect(@syntax.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
    end

    it 'Correct data capture (conditional - method)' do
       path =
        'spec/samples/rubySyntaxParts/conditionalStatment/methodConditional.rb'

      instances = openFile(path)
      @syntax.analyse_source(instances[0], instances[1])

      allMethod0 = @syntax.fileElements[0].classes[0].methods[0]
                                        .managerCondLoopAndBlock.basicStructure
      allMethod1 = @syntax.fileElements[0].classes[0].methods[1]
                                        .managerCondLoopAndBlock.basicStructure
      allMethod2 = @syntax.fileElements[0].classes[0].methods[2]
                                        .managerCondLoopAndBlock.basicStructure
      allMethod3 = @syntax.fileElements[0].classes[0].methods[3]
                                        .managerCondLoopAndBlock.basicStructure

      expect(@syntax.fileElements[0].classes[0].methods[0].name)
        .to eq('method1')

      expect(allMethod0[0].expression).to eq('x > 3')
      expect(allMethod0[0].type).to eq(Languages::IF_LABEL)

      expect(@syntax.fileElements[0].classes[0].methods[1].name)
        .to eq('method2')
      expect(allMethod1[0].expression).to eq('b && c')
      expect(allMethod1[0].type).to eq(Languages::IF_LABEL)

      expect(@syntax.fileElements[0].classes[0].methods[2].name)
        .to eq('method3')
      expect(allMethod2[0].expression).to eq('b == 3')
      expect(allMethod2[1].expression).to eq('b < 7')

      expect(allMethod2[0].type).to eq(Languages::IF_LABEL)

      expect(@syntax.fileElements[0].classes[0].methods[3].name)
        .to eq('method4')
      expect(allMethod3[0].expression).to eq('x')
    end

    it 'Correct state transition (Constructor).' do
      path = 'spec/samples/rubySyntaxParts/' +
              'conditionalStatment/constructorConditional.rb'

      expect(@syntax.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
      instances = openFile(path)
      @syntax.analyse_source(instances[0], instances[1])

      expect(@syntax.state)
        .to be_instance_of(StateMachine::OOStructuredFSM::IdleState)
    end

    it 'Correct data capture (conditional - method)' do
       path = 'spec/samples/rubySyntaxParts/' +
                'conditionalStatment/constructorConditional.rb'

      instances = openFile(path)
      @syntax.analyse_source(instances[0], instances[1])

      allConstructor = @syntax.fileElements[0].classes[0].constructors[0]
                                        .managerCondLoopAndBlock.basicStructure
      expect(@syntax.fileElements[0].classes[0].constructors[0].name)
          .to eq('initialize')

      expect(allConstructor[0].expression).to eq('a > b')
      expect(allConstructor[0].type).to eq(Languages::IF_LABEL)

      expect(allConstructor[1].expression).to eq('x')
      expect(allConstructor[1].type).to eq(Languages::CASE_LABEL)

      expect(allConstructor[2].expression).to eq('3')
      expect(allConstructor[2].type).to eq(Languages::WHEN_LABEL)
      expect(allConstructor[3].expression).to eq('8')
      expect(allConstructor[3].type).to eq(Languages::WHEN_LABEL)
      expect(allConstructor[4].expression).to eq('90')
      expect(allConstructor[4].type).to eq(Languages::WHEN_LABEL)
      expect(allConstructor[5].type).to eq(Languages::ELSE_LABEL)

      expect(allConstructor[6].expression).to eq('u && y')
      expect(allConstructor[6].type).to eq(Languages::IF_LABEL)

      expect(allConstructor[7].expression).to eq('u == 1')
      expect(allConstructor[7].type).to eq(Languages::ELSIF_LABEL)
    end

    it 'Correct data capture (repetition[while] -  Method)' do
       path = 'spec/samples/rubySyntaxParts/repetition/simpleRepetition.rb'

      instances = openFile(path)
      @syntax.analyse_source(instances[0], instances[1])

      allLoop = @syntax.fileElements[0].classes[0]
                        .methods[0].managerCondLoopAndBlock.basicStructure

      expect(@syntax.fileElements[0].classes[0].methods[0].name)
              .to eq('simple1')
      expect(allLoop[0].expression).to eq('i < num')
    end

    it 'Correct data capture (repetiton[util] - Method)' do
      path = 'spec/samples/rubySyntaxParts/repetition/simpleRepetition.rb'

      instances = openFile(path)
      @syntax.analyse_source(instances[0], instances[1])

      expect(@syntax.fileElements[0].classes[0].methods[1].name)
          .to eq('simple2')

      all = @syntax.fileElements[0].classes[0].methods[1]
                    .managerCondLoopAndBlock.basicStructure
      expect(all[0].expression).to eq('i > num')

    end

    it 'Correct data capture (repetition[for] -  Method)' do
      path = 'spec/samples/rubySyntaxParts/repetition/simpleRepetition.rb'

      instances = openFile(path)
      @syntax.analyse_source(instances[0], instances[1])

      expect(@syntax.fileElements[0].classes[0].methods[1].name)
          .to eq('simple2')

      all = @syntax.fileElements[0].classes[0].methods[1]
                    .managerCondLoopAndBlock.basicStructure
      expect(all[1].expression).to eq('i in 0..5')
    end

  end

  context 'Comments' do

    it 'Correct single line comment capture - Globals' do
      pending("The comments extracted by the preparser are not integrated to" \
               " the analyse_first_step yet")
      
      path = 'spec/samples/rubySyntaxParts/' +
              'comment/simple_single_line_comment_global.rb'

      instances = openFile(path)
      @syntax.analyse_source(instances[0], instances[1])

      expect(@syntax.fileElements[0].comments).to eq('First comment')
      expect(@syntax.fileElements[0].global_functions[0].comments)
              .to eq('Comment 2')
      expect(@syntax.fileElements[0].global_functions[1].comments)
              .to eq('Combo comment p1 Combo comment p2')
      expect(@syntax.fileElements[0].global_variables[0].comments)
              .to eq('Comment 4')
    end

    it 'Correct single line comment capture - Class' do
      pending("The comments extracted by the preparser are not integrated to" \
               " the analyse_first_step yet")

      path = 'spec/samples/rubySyntaxParts/' +
              'comment/simple_single_line_comment_class.rb'

      instances = openFile(path)
      @syntax.analyse_source(instances[0], instances[1])

      expect(@syntax.fileElements[0].classes[0].comments)
              .to eq('Comment 1: class')
      expect(@syntax.fileElements[0].classes[0].constructors[0].comments)
              .to eq('Comment 2: constructor')
      expect(@syntax.fileElements[0].classes[0].methods[0].comments)
              .to eq('Comment 3: method')
      expect(@syntax.fileElements[0].classes[0].methods[1].comments)
              .to eq('Comment 4: Combo 1 Comment 5: '+
                      'Combo 2 Comment 6: Combo 3; Combo 4')
      expect(@syntax.fileElements[0].classes[0].attributes[0].comments)
              .to eq ('Comment 7: Attribute')
    end

    it 'Correct multiple line comment capture - Global' do
      pending("The comments extracted by the preparser are not integrated to" \
               " the analyse_first_step yet")

      path = 'spec/samples/rubySyntaxParts/' +
              'comment/simple_multiple_line_comment_global.rb'

      instances = openFile(path)
      @syntax.analyse_source(instances[0], instances[1])

      expect(@syntax.fileElements[0].comments)
        .to eq('Comment 1: Multiple line')
      expect(@syntax.fileElements[0].global_functions[0].comments)
              .to eq('Global Function number one multiple line')
      expect(@syntax.fileElements[0].global_variables[0].comments)
              .to eq('global')
    end

    it 'Correct multiple line comment capture - Class' do
      pending("The comments extracted by the preparser are not integrated to" \
               " the analyse_first_step yet")

      path = 'spec/samples/rubySyntaxParts/' +
              'comment/simple_multiple_line_comment_class.rb'

      instances = openFile(path)
      @syntax.analyse_source(instances[0], instances[1])

      expect(@syntax.fileElements[0].classes[0].comments)
              .to eq('This is the first class of this file')
      expect(@syntax.fileElements[0].classes[0].constructors[0].comments)
              .to eq('Constructor initialize')
      expect(@syntax.fileElements[0].classes[0].methods[0].comments)
              .to eq('First method')
      expect(@syntax.fileElements[0].classes[0].methods[1].comments)
              .to eq('methodTwo')
      expect(@syntax.fileElements[0].classes[0].methods[2].comments)
              .to eq('method;Three')

    end

  end

  context 'Aggregation' do

    it 'Aggregation single line capture in constructor' do
      path = 'spec/samples/rubySyntaxParts/' +
              'aggregation/constructorAggregation.rb'

      instances = openFile(path)
      @syntax.analyse_source(instances[0], instances[1])


      expect(@syntax.fileElements[0].classes[2].aggregations[0].name)
        .to eq('Foo')
      expect(@syntax.fileElements[0].classes[2].aggregations[1].name)
        .to eq('Blah')
    end

    it 'Aggregation single line capture in method' do
      path = 'spec/samples/rubySyntaxParts/' +
              'aggregation/methodAggregation.rb'

      instances = openFile(path)
      @syntax.analyse_source(instances[0], instances[1])


      expect(@syntax.fileElements[0].classes[2].aggregations[0].name)
        .to eq('Test1')
      expect(@syntax.fileElements[0].classes[2].aggregations[1].name)
        .to eq('Test2')
    end

    it 'Aggregation single line capture in class' do
      path = 'spec/samples/rubySyntaxParts/' +
              'aggregation/classAggregation.rb'

      instances = openFile(path)
      @syntax.analyse_source(instances[0], instances[1])


      expect(@syntax.fileElements[0].classes[2].aggregations[0].name)
        .to eq('Class1')
      expect(@syntax.fileElements[0].classes[2].aggregations[1].name)
        .to eq('Class2')
    end

    it 'All aggregations in Metadata array' do
      path = 'spec/samples/rubySyntaxParts/' +
              'aggregation/classAggregation.rb'


      instances = openFile(path)
      @syntax.analyse_source(instances[0], instances[1])


      expect(@syntax.metadata.allAggregations.size).to eq(2)
      expect(@syntax.metadata.allAggregations[0].name).to eq('Class1')
      expect(@syntax.metadata.allAggregations[1].name).to eq('Class2')

    end

  end

  context 'Second parser' do

    it 'All Classes should be sorted by name' do
       path = 'spec/samples/rubySyntaxParts/' +
              'aggregation/multipleAggregation.rb'

       instances = openFile(path)
      @syntax.analyse_source(instances[0], instances[1])


       expect(@syntax.metadata.allClasses.size).to eq(5)
       expect(@syntax.metadata.allClasses[0].name).to eq('Class1')
       expect(@syntax.metadata.allClasses[1].name).to eq('Class2')
       expect(@syntax.metadata.allClasses[2].name).to eq('Class3')
       expect(@syntax.metadata.allClasses[3].name).to eq('Class4')
       expect(@syntax.metadata.allClasses[4].name).to eq('Class5')

    end

    it 'All Aggregation should be sorted by name and be unique' do
      path = 'spec/samples/rubySyntaxParts/' +
              'aggregation/multipleAggregation.rb'

      instances = openFile(path)
      @syntax.analyse_source(instances[0], instances[1])


      expect(@syntax.metadata.allAggregations.size).to eq(5)
      expect(@syntax.metadata.allAggregations[0].name).to eq('Array')
      expect(@syntax.metadata.allAggregations[1].name).to eq('Class1')
      expect(@syntax.metadata.allAggregations[2].name).to eq('Class2')
      expect(@syntax.metadata.allAggregations[3].name).to eq('Class3')
      expect(@syntax.metadata.allAggregations[4].name).to eq('Set')
    end

    it 'Ruby default classes should not be present in Aggregation' do
      path = 'spec/samples/rubySyntaxParts/' +
              'aggregation/multipleAggregation.rb'

      instances = openFile(path)
      @syntax.analyse_source(instances[0], instances[1])


      expect(@syntax.fileElements[0].classes[4].aggregations.size).to eq(3)
      expect(@syntax.fileElements[0].classes[4].aggregations[0].name)
        .to eq('Class1')
      expect(@syntax.fileElements[0].classes[4].aggregations[1].name)
        .to eq('Class2')
      expect(@syntax.fileElements[0].classes[4].aggregations[2].name)
        .to eq('Class3')
    end

  end

  context 'Verify line_inspect' do
    it 'get an object method' do
      object = @syntax.line_inspect(StateMachine::METHOD_ID, 'def yes_i_am')
      expect(object).to be_a Languages::MethodData
    end

    it 'get an object constructor' do
      object = @syntax.line_inspect(StateMachine::CONSTRUCTOR_ID, 'def initialize')
      expect(object).to be_a Languages::ConstructorData
    end

    it 'get an object function' do
      object = @syntax.line_inspect(StateMachine::FUNCTION_ID, 'def blabla')
      expect(object).to be_a Languages::FunctionData
    end

    it 'get an object variable' do
      object = @syntax.line_inspect(StateMachine::VARIABLE_ID, 'xpto = 1')
      expect(object).to be_a Array
    end

    it 'get an object module' do
      object = @syntax.line_inspect(StateMachine::MODULE_ID, 'module Xpto')
      expect(object).to be_a Languages::ModuleNamespaceData
    end

    it 'get an object class' do
      object = @syntax.line_inspect(StateMachine::CLASS_ID, 'class Xpto')
      expect(object).to be_a Languages::ClassData
    end

    it 'get an object repetition' do
      object = @syntax.line_inspect(StateMachine::REPETITION_ID, 'while $i < $num  do')
      expect(object).to be_a Languages::RepetitionData
    end

    it 'get an object conditional' do
      object = @syntax.line_inspect(StateMachine::CONDITIONAL_ID, 'if 3 > 2')
      expect(object).to be_a Languages::ConditionalData
    end

    it 'get an object attribute' do
      object = @syntax.line_inspect(StateMachine::ATTRIBUTE_ID, '@abc')
      expect(object).to be_a Array
    end

    it 'get an object block' do
      object = @syntax.line_inspect(StateMachine::BLOCK_ID, 'abc.each do |x|')
      expect(object).to be_a Languages::BlockData
    end

    it 'get an object extern requirement' do
      object = @syntax.line_inspect(StateMachine::EXTERN_REQUIREMENT_ID, 'require \'xpto\'')
      expect(object).to be_a Languages::ExternRequirementData
    end

  end

  after :each do
    @syntax = nil
  end

end
