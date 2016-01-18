require_relative '../../../../spec_helper'

RSpec.describe "Verify repetition output" do

  before :each do
    @path = "./spec/language/ruby/global_test/repetition/.kuniri8.yml"
    @kuniri = Kuniri::Kuniri.new
    @kuniri.read_configuration_file(@path)
    @kuniri.run_analysis
    parser = Parser::XMLOutputFormat.new(@kuniri.configurationInfo[:output])
    parser.create_all_data(@kuniri.get_parser())
    @output = File.open("./spec/language/ruby/global_test/repetition/constructorWitHvERYmIXrepetition.xml", "r")
  end

  RSpec.shared_examples "Constructor multiple verification" do |regex, description|

    it "Constructor: #{description}" do
      repetition = nil
      @output.each do |line|
        repetition = line =~ regex
      end
      expect(repetition).not_to be_nil
    end

  end

  context "Test mix repetition" do

    message = "Constructor: for level0 in 0..5"
    regex = /\s+<for\sexpression="level0 in 0..5"\slevel="0"\/?>/
    include_examples "Constructor multiple verification" , regex, message

    message = "Constructor: until level0 >gt; $num do"
    regex = /\s+<until\sexpression="level0 >gt; \$num"\slevel="0"\/?>/
    include_examples "Constructor multiple verification" , regex, message

    message = "Constructor: while level0 <lt; $num do"
    regex = /\s+<while\sexpression="level0 <lt; \$num"\slevel="0"\/?>/
    include_examples "Constructor multiple verification" , regex, message

    message = "Constructor: for level0 in 0..5"
    regex = /\s+<for\sexpression="level0 in 0..5"\slevel="0"\/?>/
    include_examples "Constructor multiple verification" , regex, message

    message = "Constructor: until level1 >gt; level0 do"
    regex = /\s+<until\sexpression="level1 >gt; level0"\slevel="1"\/?>/
    include_examples "Constructor multiple verification" , regex, message

    message = "Constructor: while level2 >gt; 8 do"
    regex = /\s+<while\sexpression="level2 >gt; 8"\slevel="2"\/?>/
    include_examples "Constructor multiple verification" , regex, message

  end

  after :each do
    @kuniri = nil
    @output = nil
  end

end
