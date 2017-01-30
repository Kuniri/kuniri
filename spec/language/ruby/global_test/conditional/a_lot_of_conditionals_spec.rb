require_relative '../../../../spec_helper'

RSpec.describe Kuniri::Kuniri do

  before :each do
    @path = "./spec/language/ruby/global_test/conditional/.kuniri2.yml"
    @kuniri = Kuniri::Kuniri.new
    @kuniri.read_configuration_file(@path)
    @kuniri.run_analysis
    parser = Parser::XMLOutputFormat.new(0, @kuniri.configurationInfo[:output])
    parser.create_all_data(@kuniri.get_parser())
    str = "./spec/language/ruby/global_test/conditional/aLotOfConditionals.xml"
    @output = File.open(str, "r")
  end

  RSpec.shared_examples "Conditional verification" do |regex, description|
    it "Method: #{description}" do
      conditional = nil
      @output.each do |line|
        conditional = line =~ regex
        break unless conditional.nil?
      end
      expect(conditional).not_to be_nil
    end
  end

  context "Test mix repetition" do

    message = "Find: if conditional1 == level0"
    regex = /\s+<if\sexpression="conditional1 == 'level0'"\slevel="0"\/?>/
    include_examples "Conditional verification" , regex, message

    message = "Find: conditional2 == level1"
    regex = /\s+<if\sexpression="conditional2 == 'level1'"\slevel="1"\/?>/
    include_examples "Conditional verification" , regex, message

    message = "Find: unless conditional3 == level1"
    regex = /\s+<unless\sexpression="conditional3 == 'level1'"\slevel="1"\/?>/
    include_examples "Conditional verification" , regex, message

    message = "Find: if xpto == level0"
    regex = /\s+<if\sexpression="xpto == 'level0'"\slevel="0"\/?>/
    include_examples "Conditional verification" , regex, message

    message = "Find: elsif abc == level0"
    regex = /\s+<elsif\sexpression="abc == 'level0'"\slevel="0"\/?>/
    include_examples "Conditional verification" , regex, message

    message = "Find: elsif banana == level0"
    regex = /\s+<elsif\sexpression="banana == 'level0'"\slevel="0"\/?>/
    include_examples "Conditional verification" , regex, message

    message = "Find: if abc == level1"
    regex = /\s+<if\sexpression="abc == 'level1'"\slevel="1"\/?>/
    include_examples "Conditional verification" , regex, message

    message = "Find: unless moreAndMore == level2"
    regex = /\s+<unless\sexpression="moreAndMore == 'level2'"\slevel="2"\/?>/
    include_examples "Conditional verification" , regex, message

    message = "Find: elsif asdf == level1"
    regex = /\s+<elsif\sexpression="asdf == 'level1'"\slevel="1"\/?>/
    include_examples "Conditional verification" , regex, message

    message = "Find: else level 1"
    regex = /\s+<else\slevel="1"\/?>/
    include_examples "Conditional verification" , regex, message

    message = "Find: else level 0"
    regex = /\s+<else\slevel="0"\/?>/
    include_examples "Conditional verification" , regex, message

    message = "Find: case p"
    regex = /\s+<case\sexpression="p"\slevel="1"\/?>/
    include_examples "Conditional verification" , regex, message

    message = "Find: when 2"
    regex = /\s+<when\sexpression="2"\slevel="1"\/?>/
    include_examples "Conditional verification" , regex, message

    message = "Find: when 4"
    regex = /\s+<when\sexpression="4"\slevel="1"\/?>/
    include_examples "Conditional verification" , regex, message

  end

  after :each do
    @kuniri = nil
    @output1 = nil
  end

end
