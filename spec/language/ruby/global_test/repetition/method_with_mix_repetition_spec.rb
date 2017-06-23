require_relative '../../../../spec_helper'

RSpec.describe "Verify repetition output" do

  before :all do
    @path = "./spec/language/ruby/global_test/repetition/.kuniri7.yml"
    @kuniri = Kuniri::Kuniri.new
    @kuniri.read_configuration_file(@path)
    @kuniri.run_analysis
    parser = Parser::XMLOutputFormat.new(0, @kuniri.configurationInfo[:output])
    parser.create_all_data(@kuniri.get_parser())
    target = "./spec/language/ruby/global_test/repetition/" +
              "methodWithMixRepetition.xml"
    @output = File.open(target, "r").read.split("\n")
  end

  RSpec.shared_examples "Method multiple verification" do |regex, description|

    it "Method: #{description}" do
      repetition = nil
      @output.each do |line|
        repetition = line =~ regex
        break unless repetition.nil?
      end
      expect(repetition).not_to be_nil
    end

  end

  context "Test mix repetition" do

    message = "Method: for level0 in 0..300"
    regex = /\s+<for\sexpression="level0 in 0\.\.300"\slevel="0"\/?>/
    include_examples "Method multiple verification" , regex, message

    message = "Method: for level1 in 0..2016"
    regex = /\s+<for\sexpression="level1 in 0..2016"\slevel="1"\/?>/
    include_examples "Method multiple verification" , regex, message

    message = "Method: until level2 < 400 do"
    regex = /\s+<until\sexpression="level2 &lt; 400"\slevel="2"\/?>/
    include_examples "Method multiple verification" , regex, message

    message = "Method: until level0 > 100 do"
    regex = /\s+<until\sexpression="level0 &gt; 100"\slevel="0"\/?>/
    include_examples "Method multiple verification" , regex, message

    message = "Method: for level1 in 2..499"
    regex = /\s+<for\sexpression="level1 in 2\.\.499"\slevel="1"\/?>/
    include_examples "Method multiple verification" , regex, message

  end

  after :all do
    @kuniri = nil
    @output = nil
  end

end
