require_relative '../spec_helper'

RSpec.describe Parser::OutputFormat do

  before :all do
    @outputFormat = Parser::OutputFormat.new
  end

  context 'Create all data' do
    it 'Try to add nil as parameter' do
      allData = @outputFormat.create_all_data(nil)
      expect(allData).to eq(nil)
    end

    #it 'Run, but raise exception' do
    #  source =
    #      'spec/samples/rubySyntaxParts/fullCode/simpleCodeWithConditional.rb'
    #  output = './'
    #  kuniri = Kuniri::Kuniri.new
    #  kuniri.set_configuration(source, 'ruby', output, 'O1')
    #  kuniri.run_analysis

    #  parser = Parser::XMLOutputFormat.new
    #  parser.set_path(p)
    #  expect{parser.create_all_data(kuniri.get_parser())}.to raise_error(
    #          NotImplementedError)
    #end
  end

  context 'Cannot call unimplemented method.' do

    it 'Generate class' do
      expect{@outputFormat.class_generate(nil)}.to raise_error(
              NotImplementedError)
    end

    it 'Generate inheritance' do
      expect{@outputFormat.inheritance_generate(nil)}.to raise_error(
              NotImplementedError)
    end

    it 'Generate parameters' do
      expect{@outputFormat.parameters_generate(nil)}.to raise_error(
              NotImplementedError)
    end

    it 'Generate attribute' do
      expect{@outputFormat.attribute_generate(nil)}.to raise_error(
              NotImplementedError)
    end

    it 'Generate function' do
      expect{@outputFormat.function_behaviour_generate('x', nil)}
        .to raise_error(NotImplementedError)
    end

    it 'Generate global variable' do
      expect{@outputFormat.global_variable_generate(nil)}.to raise_error(
              NotImplementedError)
    end

    it 'Generate require' do
      expect{@outputFormat.extern_requirement_generate(nil)}.to raise_error(
              NotImplementedError)
    end

    it 'Generate basic structure' do
      expect{@outputFormat.basic_structure_generate(nil)}.to raise_error(
              NotImplementedError)
    end

    it 'Generate aggregation' do
      expect{@outputFormat.aggregation_generate(nil)}.to raise_error(
              NotImplementedError)
    end

    it 'Generate conditional' do
      expect{@outputFormat.conditional_generate(nil)}.to raise_error(
              NotImplementedError)
    end

    it 'Generate repetition' do
      expect{@outputFormat.repetition_generate(nil)}.to raise_error(
              NotImplementedError)
    end

  end

  after :all do
    @outputFormat = nil
  end
end
