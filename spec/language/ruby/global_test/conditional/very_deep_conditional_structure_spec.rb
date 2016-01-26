require_relative '../../../../spec_helper'

RSpec.describe Kuniri::Kuniri do

  before :each do
    @path = "./spec/language/ruby/global_test/conditional/.kuniri3.yml"
    @kuniri = Kuniri::Kuniri.new
    @kuniri.read_configuration_file(@path)
    @kuniri.run_analysis
    parser = Parser::XMLOutputFormat.new(@kuniri.configurationInfo[:output])
    parser.create_all_data(@kuniri.get_parser())
    target = "./spec/language/ruby/global_test/conditional/" +
              "veryDeepConditionalStructure.xml"
    @output = File.open(target, "r")
  end

  RSpec.shared_examples "Deep conditional" do |regex, description|
    it "Method: #{description}" do
      conditional = nil
      @output.each do |line|
        conditional = line =~ regex
        break unless conditional.nil?
      end
      expect(conditional).not_to be_nil
    end
  end

  context "Very deep conditional" do

    message = "Find: if conditional0 == 'level0'"
    regex = /\s+<if\sexpression="conditional0 == 'level0'"\slevel="0"\/?>/
    include_examples "Constructor with conditional" , regex, message

    message = "Find: if conditional1 == 'level1'"
    regex = /\s+<if\sexpression="conditional1 == 'level1'"\slevel="1"\/?>/
    include_examples "Constructor with conditional" , regex, message

    message = "Find: if conditional2 == 'level2'"
    regex = /\s+<if\sexpression="conditional2 == 'level2'"\slevel="2"\/?>/
    include_examples "Constructor with conditional" , regex, message

    message = "Find: if conditional2 == 'level2'"
    regex = /\s+<if\sexpression="conditional15 == 'level15'"\slevel="15"\/?>/
    include_examples "Constructor with conditional" , regex, message

    message = "Find: if conditional19 == 'level19'"
    regex = /\s+<if\sexpression="conditional19 == 'level19'"\slevel="19"\/?>/
    include_examples "Constructor with conditional" , regex, message

    message = "Find: elsif firstElse == 'level19'"
    regex = /\s+<elsif\sexpression="firstElse == 'level19'"\slevel="19"\/?>/
    include_examples "Constructor with conditional" , regex, message

  end

  after :each do
    @kuniri = nil
    @output = nil
  end

end
