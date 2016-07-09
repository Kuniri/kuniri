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
    # TODO
  end

  context 'Add method correctly' do
    # TODO
  end

  context 'Add constructor correctly' do
    # TODO
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
