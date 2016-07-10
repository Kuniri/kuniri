require_relative '../../../spec_helper'

RSpec.describe Languages::ClassData do

  before :each do
    @classData = Languages::ClassData.new
    @classData.name = 'Xpto'
  end

  context 'When set and get class name' do

    it 'Get class name.' do
      expect(@classData.name).to eq('Xpto')
    end

    it 'Set class name.' do
      @classData.name = 'Abc'
      expect(@classData.name).to eq('Abc')
    end

    it 'Visibility.' do
      expect(@classData.visibility).to eq('public')

      @classData.visibility = 'private'
      expect(@classData.visibility).to eq('private')
    end
  end

  context 'Add attribute correctly' do
    it 'Normal behaviour to add attribute' do
      attrs = ['attr1', 'attr2']
      expect(@classData.attributes).to eq([])
      attr1 = Languages::AttributeData.new(attrs[0])
      attr2 = Languages::AttributeData.new(attrs[1])
      @classData.add_attribute([attr1])
      expect(@classData.attributes).to match_array([attr1])
      @classData.add_attribute([attr2])
      expect(@classData.attributes).to match_array([attr1, attr2])
    end

    it 'Try to add something different of AttributeData' do
      expect(@classData.attributes).to eq([])
      fake_attr = Languages::MethodData.new('abc')
      @classData.add_attribute([fake_attr])
      expect(@classData.attributes).to eq([])
      @classData.add_attribute([1, 3, 4, 5])
      expect(@classData.attributes).to eq([])
    end
  end

  context 'Add method correctly' do
    it 'Normal behaviour when try to add methods inside class' do
      expect(@classData.methods).to eq([])
      method1 = Languages::MethodData.new('m1')
      @classData.add_method(method1)
      expect(@classData.methods).to match_array([method1])
      method2 = Languages::MethodData.new('m2')
      @classData.add_method(method2)
      expect(@classData.methods).to match_array([method1, method2])
    end

    it 'Try to add something different of MethodData' do
      expect(@classData.methods).to eq([])
      fake_method = Languages::AttributeData.new('abc')
      @classData.add_method(fake_method)
      expect(@classData.methods).to eq([])
    end
  end

  context 'Add constructor correctly' do
    it 'Normal behaviour when add constructors' do
      expect(@classData.constructors).to eq([])
      const1 = Languages::ConstructorData.new('abc')
      @classData.add_constructor(const1)
      expect(@classData.constructors).to match_array([const1])
      const2 = Languages::ConstructorData.new('abc2')
      @classData.add_constructor(const2)
      expect(@classData.constructors).to match_array([const1, const2])
    end

    it 'Try to add something different of ConstructorData' do
      fake_const = Languages::MethodData.new('abc')
      @classData.add_constructor(fake_const)
      expect(@classData.constructors).to match_array([])
    end
  end

  context 'Add inheritance correctly' do
    it 'Simple case of add inheritance' do
      expect(@classData.inheritances).to eq([])

      @classData.add_inheritance('Kuniri')
      expect(@classData.inheritances).to match_array(['Kuniri'])
      @classData.add_inheritance('Now')
      expect(@classData.inheritances).to match_array(['Kuniri', 'Now'])
    end

    it 'Should not accept repetition' do
      expect(@classData.inheritances).to eq([])

      @classData.add_inheritance('Kuniri')
      expect(@classData.inheritances).to match_array(['Kuniri'])
      @classData.add_inheritance('Kuniri')
      expect(@classData.inheritances).to match_array(['Kuniri'])
      @classData.add_inheritance('Now')
      expect(@classData.inheritances).to match_array(['Kuniri', 'Now'])
    end

    it 'Wrong type of inheritance' do
      expect(@classData.inheritances).to eq([])

      @classData.add_inheritance(['NotAllowed'])
      expect(@classData.inheritances).to eq([])
    end
  end

  RSpec.shared_examples 'Add attribute' do |attributes, description|

    it ": #{description}" do

      listOfAttributes = []

      attributes.each do |nameElement|
        listOfAttributes.push(Languages::AttributeData.new(nameElement))
      end

      @classData.add_attribute(listOfAttributes)

      attributeList = @classData.attributes
      listResult = []

      attributeList.each do |element|
        listResult.push(element.name)
      end

      expect(listResult).to match_array(attributes)
    end

  end

  RSpec.shared_examples 'Add method' do |methods, description|

    it ": #{description}" do

      methods.each do |element|
        method = Languages::FunctionData.new(element)
        @classData.add_method(method)
      end

      methodList = @classData.get_methods
      listResult = []
      methodList.each do |element|
        listResult.push(element.name)
      end
      expect(listResult).to match_array(methods)
    end

  end

  after :each do
    @classData = nil
  end

end
