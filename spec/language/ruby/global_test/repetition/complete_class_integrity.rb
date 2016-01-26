require_relative '../../../../spec_helper'

RSpec.describe "Complete class integrity" do

  before :each do
    @path = "./spec/language/ruby/global_test/repetition/.kuniri.yml"
    @kuniri = Kuniri::Kuniri.new
    @kuniri.read_configuration_file(@path)
    @kuniri.run_analysis
    parser = Parser::XMLOutputFormat.new(@kuniri.configurationInfo[:output])
    parser.create_all_data(@kuniri.get_parser())
    target = "./spec/language/ruby/global_test/repetition/forLoopInClass.xml"
    @output = File.open(target, "r")
  end

  context "Test output integrity" do

    it "Repetition: verify the opening-closing structure" do
      @stack = []
      @output.each do |line|
        next if line =~ /<\?xml.*/
        next if line =~ /.*\/>/

        if line =~ /\s*<\/(\w*)>/
          expect(@stack.last).to eq($1)
          @stack.pop
        elsif line =~ /\s*<(\w*)(.*)>/
          @stack.push $1
        end
      end

      expect(@stack.size).to eq(0)

  end

  after :each do
    @kuniri = nil
    @output = nil
  end

end
