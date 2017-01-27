require_relative '../../../../spec_helper'

RSpec.describe "Verify class with while loop" do

  before :each do
    @path = "./spec/language/ruby/global_test/repetition/.kuniri2.yml"
    @kuniri = Kuniri::Kuniri.new
    @kuniri.read_configuration_file(@path)
    @kuniri.run_analysis
    parser = Parser::XMLOutputFormat.new(0, @kuniri.configurationInfo[:output])
    parser.create_all_data(@kuniri.get_parser())
    target = "./spec/language/ruby/global_test/repetition/whileLoopInClass.xml"
    @output = File.open(target, "r")
  end

  RSpec.shared_examples "Class with while" do |regex, description|

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
    regex = /\s+<while\sexpression="\$i &lt; \$num" level="0"\/>/
    include_examples "Class with while" , regex, message

  end

  after :each do
    @kuniri = nil
    @output = nil
  end
end
