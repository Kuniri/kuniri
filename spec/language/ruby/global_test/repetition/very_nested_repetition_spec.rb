require_relative '../../../../spec_helper'

RSpec.describe "Verify repetition output with a nested conditional" do

  before :each do
    @path = "./spec/language/ruby/global_test/repetition/.kuniri6.yml"
    @kuniri = Kuniri::Kuniri.new
    @kuniri.read_configuration_file(@path)
    @kuniri.run_analysis
    parser = Parser::XMLOutputFormat.new(@kuniri.configurationInfo[:output])
    parser.create_all_data(@kuniri.get_parser())
    @output = File.open("./spec/language/ruby/global_test/repetition/veryNestedRepetition.xml", "r")
  end

  RSpec.shared_examples "Nested multiple verification" do |regex, description|

    it "Global Function: #{description}" do
      repetition = nil
      @output.each do |line|
        repetition = line =~ regex
      end
      expect(repetition).not_to be_nil
    end

  end

  context "Test neted repetition" do

    message = "Global Function: for level0 in 0..5"
    regex = /\s+<for\sexpression="level0 in 0\.\.5"\slevel="0"\/?>/
    include_examples "Nested multiple verification" , regex, message

    message = "Global Function: for level1 in 0..6"
    regex = /\s+<for\sexpression="level1 in 0\.\.6"\slevel="1"\/?>/
    include_examples "Nested multiple verification" , regex, message

    message = "Global Function: for level2 in 0..7"
    regex = /\s+<for\sexpression="level2 in 0\.\.7"\slevel="2"\/?>/
    include_examples "Nested multiple verification" , regex, message

    message = "Global Function: for level3 in 0..8"
    regex = /\s+<for\sexpression="level3 in 0\.\.8"\slevel="3"\/?>/
    include_examples "Nested multiple verification" , regex, message

    message = "Global Function: for level4 in 0..9"
    regex = /\s+<for\sexpression="level4 in 0\.\.9"\slevel="4"\/?>/
    include_examples "Nested multiple verification" , regex, message

    message = "Global Function: for level5 in 0..10"
    regex = /\s+<for\sexpression="level5 in 0\.\.10"\slevel="5"\/?>/
    include_examples "Nested multiple verification" , regex, message

    message = "Global Function: for level6 in 0..11"
    regex = /\s+<for\sexpression="level6 in 0\.\.11"\slevel="6"\/?>/
    include_examples "Nested multiple verification" , regex, message

  end

  after :each do
    @kuniri = nil
    @output = nil
  end

end
