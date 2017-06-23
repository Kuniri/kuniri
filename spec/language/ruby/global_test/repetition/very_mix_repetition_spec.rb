require_relative '../../../../spec_helper'

RSpec.describe "Verify repetition output" do

  before :all do
    @path = "./spec/language/ruby/global_test/repetition/.kuniri5.yml"
    @kuniri = Kuniri::Kuniri.new
    @kuniri.read_configuration_file(@path)
    @kuniri.run_analysis
    parser = Parser::XMLOutputFormat.new(0, @kuniri.configurationInfo[:output])
    parser.create_all_data(@kuniri.get_parser())
    @output = File.open("./spec/language/ruby/global_test/repetition/veryMixRepetition.xml", "r").read.split("\n")
  end

  RSpec.shared_examples "Mix multiple verification" do |regex, description|

    it "Global Function: #{description}" do
      repetition = nil
      @output.each do |line|
        repetition = line =~ regex
        break unless repetition.nil?
      end
      expect(repetition).not_to be_nil
    end

  end

  context "Test mix repetition" do

    message = "Global Function: for level0 in 0..5"
    regex = /\s+<for\sexpression="level0 in 0\.\.5"\slevel="0"\/?>/
    include_examples "Mix multiple verification" , regex, message

    message = "Global Function: until level0 &gt; $num do"
    regex = /\s+<until\sexpression="level0 &gt; \$num"\slevel="0"\/?>/
    include_examples "Mix multiple verification" , regex, message

    message = "Global Function: while level0 &lt; $num do"
    regex = /\s+<while\sexpression="level0 &lt; \$num"\slevel="0"\/?>/
    include_examples "Mix multiple verification" , regex, message

    message = "Global Function: for level0 in 0..5"
    regex = /\s+<for\sexpression="level0 in 0..5"\slevel="0"\/?>/
    include_examples "Mix multiple verification" , regex, message

    message = "Global Function: until level1 &gt; level0 do"
    regex = /\s+<until\sexpression="level1 &gt; level0"\slevel="1"\/?>/
    include_examples "Mix multiple verification" , regex, message

    message = "Global Function: while level2 &gt; 8 do"
    regex = /\s+<while\sexpression="level2 &gt; 8"\slevel="2"\/?>/
    include_examples "Mix multiple verification" , regex, message

  end

  after :all do
    @kuniri = nil
    @output = nil
  end

end
