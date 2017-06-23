require_relative '../../../../spec_helper'

RSpec.describe Kuniri::Kuniri do

  before :all do
    @path = "./spec/language/ruby/global_test/conditional/.kuniri1.yml"
    @kuniri = Kuniri::Kuniri.new
    @kuniri.read_configuration_file(@path)
    @kuniri.run_analysis
    parser = Parser::XMLOutputFormat.new(0, @kuniri.configurationInfo[:output])
    parser.create_all_data(@kuniri.get_parser())
    target = "./spec/language/ruby/global_test/conditional/output1.xml"
    @output = File.open(target, "r").read.split("\n")
  end

  RSpec.shared_examples "Nested conditional" do |regex, description|
    it "Nested: #{description}" do
      conditional = nil
      @output.each do |line|
        conditional = line =~ regex
        break unless conditional.nil?
      end
      expect(conditional).not_to be_nil
    end
  end

  context "Function with nested conditional" do

    message = "Find: if xpto == 'level0'"
    regex = /\s+<if\sexpression="xpto == 'level0'"\slevel="0"\/?>/
    include_examples "Nested conditional" , regex, message

    message = "Find: if abc == 'level1'"
    regex = /\s+<if\sexpression="abc == 'level1'"\slevel="1"\/?>/
    include_examples "Nested conditional" , regex, message

    message = "Find: if xyz == 'level0'"
    regex = /\s+<if\sexpression="xyz == 'level0'"\slevel="0"\/?>/
    include_examples "Nested conditional" , regex, message

    message = "Find: if abc == 'level1'"
    regex = /\s+<if\sexpression="abc == 'level1'" level="1"\/?>/
    include_examples "Nested conditional" , regex, message

    message = "Find: else"
    regex = /\s+<else level="1"\/?>/
    include_examples "Nested conditional" , regex, message

  end

  after :all do
    @kuniri = nil
    @output = nil
  end

end
