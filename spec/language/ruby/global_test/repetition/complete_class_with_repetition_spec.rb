require_relative '../../../../spec_helper'

RSpec.describe Kuniri::Kuniri do

  before :each do
    @path = "./spec/language/ruby/global_test/repetition/.kuniri4.yml"
    @kuniri = Kuniri::Kuniri.new
    @kuniri.read_configuration_file(@path)
    @kuniri.run_analysis
    parser = Parser::XMLOutputFormat.new(@kuniri.configurationInfo[:output])
    parser.create_all_data(@kuniri.get_parser())
    target = "./spec/language/ruby/global_test/repetition/forLoopInClass.xml"
    @output = File.open(target, "r")
  end

  RSpec.shared_examples "Complete class with repetition" do |regex, description|

    it "Method: #{description}" do
      repetition = nil
      @output.each do |line|
        repetition = line =~ regex
        break unless repetition.nil?
      end
      expect(repetition).not_to be_nil
    end

  end

  context "Validate for loop" do

    message = "Method: for i in 0..5"
    regex = /\s+<for\sexpression="i in 0\.\.5" level="0"\/>/
    include_examples "Complete class with repetition", regex, message

  end

  after :each do
    @kuniri = nil
    @output = nil
  end

end
