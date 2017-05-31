require_relative '../../../../spec_helper'

def load_fixture(yml_path)
  kuniri = Kuniri::Kuniri.new
  kuniri.read_configuration_file(yml_path)
  kuniri.run_analysis
  parser = Parser::XMLOutputFormat.new(0, kuniri.configurationInfo[:output])
  parser.create_all_data(kuniri.get_parser())
  return File.open(kuniri.configurationInfo[:output], 'r').readlines()
end

RSpec.describe "Class counter evaluation" do

  it 'File with one class definition and nothing else' do
    yml_path = './spec/language/ruby/global_test/metrics/.kuniri.yml'
    output = load_fixture(yml_path)
    expect(output.include? "  <totalClasses counter=\"1\"/>\n").to eq(true)
  end

  it 'File with no class definition' do
    yml_path = './spec/language/ruby/global_test/metrics/.kuniri2.yml'
    output = load_fixture(yml_path)
    expect(output.include? "  <totalClasses counter=\"0\"/>\n").to eq(true)
  end
end
