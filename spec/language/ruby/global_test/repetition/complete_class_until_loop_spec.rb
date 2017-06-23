require_relative '../../../../spec_helper'

RSpec.describe "Verify class with while loop" do

  before :all do
    @path = "./spec/language/ruby/global_test/repetition/.kuniri3.yml"
    @kuniri = Kuniri::Kuniri.new
    @kuniri.read_configuration_file(@path)
    @kuniri.run_analysis
    parser = Parser::XMLOutputFormat.new(0, @kuniri.configurationInfo[:output])
    parser.create_all_data(@kuniri.get_parser())
    target = "./spec/language/ruby/global_test/repetition/untilInClass.xml"
    @output = File.open(target, "r").read.split("\n")
  end

  RSpec.shared_examples "Class with until" do |regex, description|

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
    regex = /\s+<until\sexpression="\$i &gt; \$num" level="0"\/>/
    include_examples "Class with until" , regex, message

  end

  after :all do
    @kuniri = nil
    @output = nil
  end

end
