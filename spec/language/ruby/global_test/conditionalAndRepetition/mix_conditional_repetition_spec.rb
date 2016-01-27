require_relative '../../../../spec_helper'

RSpec.describe "Mix conditional and repetition in the same code" do

  before :each do
    @path = "./spec/language/ruby/global_test/conditionalAndRepetition/.kuniri.yml"
    @kuniri = Kuniri::Kuniri.new
    @kuniri.read_configuration_file(@path)
    @kuniri.run_analysis
    parser = Parser::XMLOutputFormat.new(@kuniri.configurationInfo[:output])
    parser.create_all_data(@kuniri.get_parser())
    @output = File.open("./spec/language/ruby/global_test/conditionalAndRepetition/mixConditionalRepetition.xml", "r")
  end

  RSpec.shared_examples "Multiple verification" do |regex, description|

    it "Global Function: #{description}" do
      mixElement = nil
      @output.each do |line|
        mixElement = line =~ regex
        break unless mixElement.nil?
      end
      expect(mixElement).not_to be_nil
    end

  end

  context "Test repetition and conditional together" do

    message = "Global Function: for level0 in 8..19"
    regex = /\s+<for\sexpression="level0 in 8\.\.19"\slevel="0"\/?>/
    include_examples "Multiple verification" , regex, message

    message = "Global Function: if level1 > 10"
    regex = /\s+<if\sexpression="level1 &gt; 10"\slevel="1"\/?>/
    include_examples "Multiple verification" , regex, message

    message = "Global Function: while level2 do"
    regex = /\s+<while\sexpression="level2"\slevel="2"\/?>/
    include_examples "Multiple verification" , regex, message

    message = "Global Function: unless level3"
    regex = /\s+<unless\sexpression="level3"\slevel="3"\/?>/
    include_examples "Multiple verification" , regex, message

    message = "Global Function: until level4 < 20 do"
    regex = /\s+<until\sexpression="level4 &lt; 20"\slevel="4"\/?>/
    include_examples "Multiple verification" , regex, message

  end

  after :each do
    @kuniri = nil
    @output = nil
  end

end
