require_relative '../../../../spec_helper'

RSpec.describe Kuniri::Kuniri do

  before :each do
    @path = "./spec/language/ruby/global_test/conditional/.kuniri3.yml"
    @kuniri = Kuniri::Kuniri.new
    @kuniri.read_configuration_file(@path)
    @kuniri.run_analysis
    parser = Parser::XMLOutputFormat.new(@kuniri.configurationInfo[:output])
    parser.create_all_data(@kuniri.get_parser())
    @output = File.open("./spec/language/ruby/global_test/conditional/veryDeepConditionalStructure.xml", "r")
  end

  context "Simple cases of nested conditional" do
    it "Find: if conditional0 == level0" do
      conditional = nil
      @output.each do |line|
        conditional = line =~ /\s+<if\sexpression="conditional0 == 'level0'"\slevel="0"\/?>/
        break unless conditional.nil?
      end
      expect(conditional).not_to be_nil
    end

    it "Find: if conditional1 == level1" do
      conditional = nil
      @output.each do |line|
        conditional = line =~ /\s+<if\sexpression="conditional1 == 'level1'"\slevel="1"\/?>/
        break unless conditional.nil?
      end
      expect(conditional).not_to be_nil
    end

   it "Find: if conditional2 == level2" do
      conditional = nil
      @output.each do |line|
        conditional = line =~ /\s+<if\sexpression="conditional2 == 'level2'"\slevel="2"\/?>/
        break unless conditional.nil?
      end
      expect(conditional).not_to be_nil
    end

   it "Find: if conditional15 == level15" do
      conditional = nil
      @output.each do |line|
        conditional = line =~ /\s+<if\sexpression="conditional15 == 'level15'"\slevel="15"\/?>/
        break unless conditional.nil?
      end
      expect(conditional).not_to be_nil
    end

   it "Find: if conditional19 == level19" do
      conditional = nil
      @output.each do |line|
        conditional = line =~ /\s+<if\sexpression="conditional19 == 'level19'"\slevel="19"\/?>/
        break unless conditional.nil?
      end
      expect(conditional).not_to be_nil
    end

   it "Find: elsif firstElse == level19" do
      conditional = nil
      @output.each do |line|
        conditional = line =~ /\s+<elsif\sexpression="firstElse == 'level19'"\slevel="19"\/?>/
        break unless conditional.nil?
      end
      expect(conditional).not_to be_nil
    end


  end 

  after :each do
    @kuniri = nil
    @output = nil
  end

end
