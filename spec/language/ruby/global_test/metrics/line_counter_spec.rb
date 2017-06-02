require_relative "../../../../spec_helper"

def load_fixture(yml_path)
  kuniri = Kuniri::Kuniri.new
  kuniri.read_configuration_file(yml_path)
  kuniri.run_analysis
  parser = Parser::XMLOutputFormat.new(0, kuniri.configurationInfo[:output])
  parser.create_all_data(kuniri.get_parser())
  return File.open(kuniri.configurationInfo[:output], 'r').readlines()
end

RSpec.describe "Line Counter Test" do
  it "No blank lines" do
    yml_path = "./spec/language/ruby/global_test/metrics/.kuniri3.yml"
    output = load_fixture(yml_path)
    expect(output.include? "  <linesOfCode counter=\"6\"/>\n").to eq(true)
  end
end

RSpec.describe "Line Counter Test" do
  it "No blank lines" do
    yml_path = "./spec/language/ruby/global_test/metrics/.kuniri4.yml"
    output = load_fixture(yml_path)
    expect(output.include? "  <linesOfCode counter=\"6\"/>\n").to eq(true)
  end
end
