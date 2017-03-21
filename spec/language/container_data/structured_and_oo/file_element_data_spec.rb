require_relative '../../../spec_helper'

RSpec.describe Languages::FileElementData do

  before :each do
    @fileElement = Languages::FileElementData.new ('test')
    @globalFunction1 = Languages::FunctionData.new('xpto')
    @globalFunction2 = Languages::FunctionData.new('second')
    @globalVariable1 = [Languages::VariableGlobalData.new('var1')]
    @globalVariable2 = [Languages::VariableGlobalData.new('var2')]
    @globalVariable3 = Languages::VariableGlobalData.new('var3')
    @externFile1 = Languages::ExternRequirementData.new ('/dir/1')
    @externFile2 = Languages::ExternRequirementData.new ('/dir/2')
    @class1 = Languages::ClassData.new
    @conditional1 = Languages::ConditionalData.new
    @conditional2 = Languages::ConditionalData.new
    @repetition1 = Languages::RepetitionData.new
    @repetition2 = Languages::RepetitionData.new
    @block1 = Languages::BlockData.new
    @block2 = Languages::BlockData.new
  end

  context 'When add global function.' do

    it 'Add one global function' do
      @fileElement.add_global_function(@globalFunction1)
      expect(@fileElement.global_functions[0].name == 'xpto').to be true
    end

    it 'Add two global functions' do
      @fileElement.add_global_function(@globalFunction1)
      @fileElement.add_global_function(@globalFunction2)
      functionName = []
      @fileElement.global_functions.each do |function|
        functionName.push(function.name)
      end
      expect(functionName).to match_array(['xpto', "second"])
    end

    it 'Add Non function data' do
      @fileElement.add_global_function('xpto')
      expect(@fileElement.global_functions).to match_array([])
    end

  end

  context 'When add global variable.' do

    it 'Add one global variable.' do
      @fileElement.add_global_variable(@globalVariable1)
      expect(@fileElement.global_variables[0].name == 'var1').to be true
    end

    it 'Add two global variable.' do
      @fileElement.add_global_variable(@globalVariable1)
      @fileElement.add_global_variable(@globalVariable2)
      variables = []
      @fileElement.global_variables.each do |variable|
        variables.push(variable.name)
      end
      expect(variables).to match_array(['var1', "var2"])
    end

    it 'Add one global variable as single parameter.' do
      @fileElement.add_global_variable(@globalVariable3)
      expect(@fileElement.global_variables[0].name == 'var3').to be true
    end

    it 'Add non global variable.' do
      @fileElement.add_global_variable(['xpto'])
      expect(@fileElement.global_variables).to match_array([])
    end

  end

  context 'When add external files.' do
    it 'Add one external element.' do
      @fileElement.add_extern_requirement(@externFile1)
      expect(@fileElement.extern_requirements[0].library == '/dir/1').to be true
    end

    it 'Add two external elements.' do
      @fileElement.add_extern_requirement(@externFile1)
      @fileElement.add_extern_requirement(@externFile2)
      extern = []
      @fileElement.extern_requirements.each do |externs|
        extern.push(externs.library)
      end
      expect(extern).to match_array(['/dir/1', "/dir/2"])
    end

    it 'Add non extern requirement.' do
      @fileElement.add_extern_requirement('xpto')
      expect(@fileElement.extern_requirements).to match_array([])
    end

  end

  context 'When instantiating' do
    it 'Does not set name' do
      @fileElement = Languages::FileElementData.new(nil)
      expect(@fileElement.name).to be_nil
      @fileElement = Languages::FileElementData.new(1)
      expect(@fileElement.name).to be_nil
    end
  end

  context 'Helpers from file elements' do
    it 'Add attribute to last class' do
      @fileElement.add_class(@class1)
      attribute = Languages::AttributeData.new('justAtest')
      @fileElement.add_attribute_to_last_class([attribute])
      expect(@fileElement.classes.last).to eq(@class1)
      expect(@fileElement.classes.last.attributes[0]).to eq(attribute)
    end

    it 'Get index from the last class' do
      @fileElement.add_class(@class1)
      expect(@fileElement.get_last_class_index).to eq(0)
      @fileElement.add_class(@class1)
      expect(@fileElement.get_last_class_index).to eq(1)
    end
  end

  context 'Add conditional directly to file' do
    it 'Simple flow of conditional addition' do
      @fileElement.add_conditional(@conditional1)
      all = @fileElement.managerCondAndLoop.basicStructure
      expect(all).to match_array([@conditional1])
      @fileElement.add_conditional(@conditional2)
      all = @fileElement.managerCondAndLoop.basicStructure
      expect(all).to match_array([@conditional1, @conditional2])
    end

    it 'Try to add something different of Conditional' do
      @fileElement.add_conditional(@class1)
      all = @fileElement.managerCondAndLoop.basicStructure
      expect(all).to match_array([])
      @fileElement.add_conditional(@repetition2)
      all = @fileElement.managerCondAndLoop.basicStructure
      expect(all).to match_array([])
    end
  end

  context 'Add repetition directly to file' do
    it 'Simple flow of repetition addition' do
      @fileElement.add_repetition(@repetition1)
      all = @fileElement.managerCondAndLoop.basicStructure
      expect(all).to match_array([@repetition1])
      @fileElement.add_repetition(@repetition2)
      all = @fileElement.managerCondAndLoop.basicStructure
      expect(all).to match_array([@repetition1, @repetition2])
    end

    it 'Try to add something different of RepetitionData' do
      @fileElement.add_repetition(@conditional1)
      @fileElement.add_repetition(@class1)
      all = @fileElement.managerCondAndLoop.basicStructure
      expect(all).to match_array([])
    end
  end

  context 'Add block directly to file' do
    it 'Simple flow of block addition' do
      @fileElement.add_block(@block1)
      all = @fileElement.managerCondAndLoop.basicStructure
      expect(all).to match_array([@block1])
      @fileElement.add_block(@block2)
      all = @fileElement.managerCondAndLoop.basicStructure
      expect(all).to match_array([@block1, @block2])
    end

    it 'Try to add something different of BlockData' do
      @fileElement.add_block(@conditional1)
      @fileElement.add_block(@class1)
      all = @fileElement.managerCondAndLoop.basicStructure
      expect(all).to match_array([])
    end
  end

  after :each do
    @fileElement = nil
  end

end
