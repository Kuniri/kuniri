require_relative '../../../../spec_helper'

RSpec.describe "Verify repetition output" do

  before :all do
    @path = "./spec/language/ruby/global_test/repetition/.kuniri8.yml"
    @kuniri = Kuniri::Kuniri.new
    @kuniri.read_configuration_file(@path)
    @kuniri.run_analysis
    parser = Parser::XMLOutputFormat.new(0, @kuniri.configurationInfo[:output])
    parser.create_all_data(@kuniri.get_parser())
    @output = File.open("./spec/language/ruby/global_test/repetition/constructorWithMixRepetition.xml", "r").read.split("\n")
  end

  RSpec.shared_examples "Constructor multiple verification" do |regex, description|

    it "Constructor: #{description}" do
      repetition = nil
      @output.each do |line|
        repetition = line =~ regex
        break unless repetition.nil?
      end
      expect(repetition).not_to be_nil
    end

  end

  context "Test mix repetition" do

    message = "Constructor: for level0 in 0..5"
    regex = /\s+<for\sexpression="level0 in 0\.\.5"\slevel="0"\/?>/
    include_examples "Constructor multiple verification" , regex, message

    message = "Constructor: until level0 &gt; 30 do"
    regex = /\s+<until\sexpression="level0 &gt; 30"\slevel="0"\/?>/
    include_examples "Constructor multiple verification" , regex, message

    message = "Constructor: for level0 in 0..5"
    regex = /\s+<for\sexpression="level0 in 0\.\.5"\slevel="0"\/?>/
    include_examples "Constructor multiple verification" , regex, message

    message = "Constructor: until level1 &gt; level0 do"
    regex = /\s+<until\sexpression="level1 &gt; 300"\slevel="1"\/?>/
    include_examples "Constructor multiple verification" , regex, message

    message = "Constructor: for level2 in 0..300"
    regex = /\s+<for\sexpression="level2 in 0\.\.300"\slevel="2"\/?>/
    include_examples "Constructor multiple verification" , regex, message

  end

  after :all do
    @kuniri = nil
    @output = nil
  end

end
