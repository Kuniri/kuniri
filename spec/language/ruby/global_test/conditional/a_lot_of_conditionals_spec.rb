require_relative '../../../../spec_helper'

RSpec.describe Kuniri::Kuniri do

  before :each do
    @path = "./spec/language/ruby/global_test/conditional/.kuniri2.yml"
    @kuniri = Kuniri::Kuniri.new
    @kuniri.read_configuration_file(@path)
    @kuniri.run_analysis
    parser = Parser::XMLOutputFormat.new(@kuniri.configurationInfo[:output])
    parser.create_all_data(@kuniri.get_parser())
    @output = File.open("./spec/language/ruby/global_test/conditional/aLotOfConditionals.xml", "r")
  end

  context "Simple cases of nested conditional" do
    it "Find: if conditional1 == level0" do
      simpleIf = nil
      @output.each do |line|
        simpleIf = line =~ /\s+<if\sexpression="conditional1 == 'level0'"\slevel="0"\/?>/
        break unless simpleIf.nil?
      end
      expect(simpleIf).not_to be_nil
    end

    it "Find: conditional2 == level1" do
      conditional = nil
      @output.each do |line|
        conditional = line =~ /\s+<if\sexpression="conditional2 == 'level1'"\slevel="1"\/?>/
        break unless conditional.nil?
      end
      expect(conditional).not_to be_nil
    end

    it "Find: unless conditional3 == level1" do
      conditional = nil
      @output.each do |line|
        conditional = line =~ /\s+<unless\sexpression="conditional3 == 'level1'"\slevel="1"\/?>/
        break unless conditional.nil?
      end
      expect(conditional).not_to be_nil
    end

    it "Find: if xpto == level0" do
      conditional = nil
      @output.each do |line|
        conditional = line =~ /\s+<if\sexpression="xpto == 'level0'"\slevel="0"\/?>/
        break unless conditional.nil?
      end
      expect(conditional).not_to be_nil
    end

    it "Find: elsif abc == level0" do
      conditional = nil
      @output.each do |line|
        conditional = line =~ /\s+<elsif\sexpression="abc == 'level0'"\slevel="0"\/?>/
        break unless conditional.nil?
      end
      expect(conditional).not_to be_nil
    end

    it "Find: elsif banana == level0" do
      conditional = nil
      @output.each do |line|
        conditional = line =~ /\s+<elsif\sexpression="banana == 'level0'"\slevel="0"\/?>/
        break unless conditional.nil?
      end
      expect(conditional).not_to be_nil
    end

    it "Find: if abc == level1" do
      conditional = nil
      @output.each do |line|
        conditional = line =~ /\s+<if\sexpression="abc == 'level1'"\slevel="1"\/?>/
        break unless conditional.nil?
      end
      expect(conditional).not_to be_nil
    end

    it "Find: unless moreAndMore == level2" do
      conditional = nil
      @output.each do |line|
        conditional = line =~ /\s+<unless\sexpression="xpto == 'level2'"\slevel="2"\/?>/
        break unless conditional.nil?
      end
      expect(conditional).not_to be_nil
    end

    it "Find: elsif asdf == level1" do
      conditional = nil
      @output.each do |line|
        conditional = line =~ /\s+<elsif\sexpression="asdf == 'level1'"\slevel="1"\/?>/
        break unless conditional.nil?
      end
      expect(conditional).not_to be_nil
    end

    it "Find: else level 1" do
      conditional = nil
      @output.each do |line|
        conditional = line =~ /\s+<else\slevel="1"\/?>/
        break unless conditional.nil?
      end
      expect(conditional).not_to be_nil
    end

    it "Find: else level 0" do
      conditional = nil
      @output.each do |line|
        conditional = line =~ /\s+<else\slevel="0"\/?>/
        break unless conditional.nil?
      end
      expect(conditional).not_to be_nil
    end

    it "Find: case p" do
      conditional = nil
      @output.each do |line|
        conditional = line =~ /\s+<case\sexpression="p"\slevel="1"\/?>/
        break unless conditional.nil?
      end
      expect(conditional).not_to be_nil
    end

    it "Find: when 2" do
      conditional = nil
      @output.each do |line|
        conditional = line =~ /\s+<when\sexpression="2"\slevel="1"\/?>/
        break unless conditional.nil?
      end
      expect(conditional).not_to be_nil
    end

    it "Find: when 4" do
      conditional = nil
      @output.each do |line|
        conditional = line =~ /\s+<when\sexpression="4"\slevel="1"\/?>/
        break unless conditional.nil?
      end
      expect(conditional).not_to be_nil
    end


  end

  after :each do
    @kuniri = nil
    @output1 = nil
  end

end
