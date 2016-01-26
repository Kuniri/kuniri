require_relative '../../../../spec_helper'

RSpec.describe Kuniri::Kuniri do

  before :each do
    @path = "./spec/language/ruby/global_test/conditional/.kuniri4.yml"
    @kuniri = Kuniri::Kuniri.new
    @kuniri.read_configuration_file(@path)
    @kuniri.run_analysis
    parser = Parser::XMLOutputFormat.new(@kuniri.configurationInfo[:output])
    parser.create_all_data(@kuniri.get_parser())
    target = "./spec/language/ruby/global_test/conditional/" +
              "veryMixConditional.xml"
    @output = File.open(target, "r")
  end

  RSpec.shared_examples "Very mix conditional" do |regex, description|
    it "Method: #{description}" do
      conditional = nil
      @output.each do |line|
        conditional = line =~ regex
        break unless conditional.nil?
      end
      expect(conditional).not_to be_nil
    end
  end

  context "Very mix with conditional" do

    message = "Find: case p"
    regex = /\s+<case\sexpression="p"\slevel="0"\/?>/
    include_examples "Very mix conditional" , regex, message

    message = "Find: when 2"
    regex = /\s+<when\sexpression="2"\slevel="0"\/?>/
    include_examples "Very mix conditional" , regex, message

    message = "Find: if xpto == 'level1'"
    regex = /\s+<if\sexpression="xpto == 'level1'"\slevel="1"\/?>/
    include_examples "Very mix conditional" , regex, message

    message = "Find: else"
    regex = /\s+<else\slevel="1"\/?>/
    include_examples "Very mix conditional" , regex, message

    message = "Find: when 4"
    regex = /\s+<when\sexpression="4"\slevel="0"\/?>/
    include_examples "Very mix conditional" , regex, message

    message = "Find: if xpto1 == 'level1'"
    regex = /\s+<if\sexpression="xpto1 == 'level1'"\slevel="1"\/?>/
    include_examples "Very mix conditional" , regex, message

    message = "Find: if xpto2 == 'level2'"
    regex = /\s+<if\sexpression="xpto2 == 'level2'"\slevel="2"\/?>/
    include_examples "Very mix conditional" , regex, message

    message = "Find: if xpto3 == 'level3'"
    regex = /\s+<if\sexpression="xpto3 == 'level3'"\slevel="3"\/?>/
    include_examples "Very mix conditional" , regex, message

    message = "Find: elsif abc == 'level3'"
    regex = /\s+<elsif\sexpression="abc == 'level3'"\slevel="3"\/?>/
    include_examples "Very mix conditional" , regex, message

    message = "Find: else"
    regex = /\s+<else\slevel="3"\/?>/
    include_examples "Very mix conditional" , regex, message

    message = "Find: elsif banana == 'level1'"
    regex = /\s+<elsif\sexpression="banana == 'level1'"\slevel="1"\/?>/
    include_examples "Very mix conditional" , regex, message

    message = "Find: when 7"
    regex = /\s+<when\sexpression="7"\slevel="0"\/?>/
    include_examples "Very mix conditional" , regex, message

    message = "Find: unless abc == 'level1'"
    regex = /\s+<unless\sexpression="abc == 'level1'"\slevel="1"\/?>/
    include_examples "Very mix conditional" , regex, message

    message = "Find: if xpto == 'level2'"
    regex = /\s+<if\sexpression="xpto == 'level2'"\slevel="2"\/?>/
    include_examples "Very mix conditional" , regex, message

    message = "Find: case x"
    regex = /\s+<case\sexpression="x"\slevel="3"\/?>/
    include_examples "Very mix conditional" , regex, message

    message = "Find: when 6"
    regex = /\s+<when\sexpression="6"\slevel="3"\/?>/
    include_examples "Very mix conditional" , regex, message

    message = "Find: when 7"
    regex = /\s+<when\sexpression="7"\slevel="3"\/?>/
    include_examples "Very mix conditional" , regex, message

  end

  after :each do
    @kuniri = nil
    @output = nil
  end

end
