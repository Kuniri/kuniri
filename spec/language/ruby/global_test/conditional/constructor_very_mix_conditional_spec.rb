require_relative '../../../../spec_helper'

RSpec.describe Kuniri::Kuniri do

  before :each do
    @path = "./spec/language/ruby/global_test/conditional/.kuniri5.yml"
    @kuniri = Kuniri::Kuniri.new
    @kuniri.read_configuration_file(@path)
    @kuniri.run_analysis
    parser = Parser::XMLOutputFormat.new(@kuniri.configurationInfo[:output])
    parser.create_all_data(@kuniri.get_parser())
    @output = File.open("./spec/language/ruby/global_test/conditional/constructorVeryMixConditional.xml", "r")
  end

  context "Constructor: Very mix conditional" do
    it "Find: case p" do
      conditional = nil
      @output.each do |line|
        conditional = line =~ /\s+<case\sexpression="p"\slevel="0"\/?>/
        break unless conditional.nil?
      end
      expect(conditional).not_to be_nil
    end

    it "Constructor: Find: when 2" do
      conditional = nil
      @output.each do |line|
        conditional = line =~ /\s+<when\sexpression="2"\slevel="0"\/?>/
        break unless conditional.nil?
      end
      expect(conditional).not_to be_nil
    end

    it "Constructor: Find: if xpto == level1" do
      conditional = nil
      @output.each do |line|
        conditional = line =~ /\s+<if\sexpression="xpto == 'level1'"\slevel="1"\/?>/
        break unless conditional.nil?
      end
      expect(conditional).not_to be_nil
    end

    it "Constructor: Find: else" do
      conditional = nil
      @output.each do |line|
        conditional = line =~ /\s+<else\slevel="1"\/?>/
        break unless conditional.nil?
      end
      expect(conditional).not_to be_nil
    end

    it "Constructor: Find: when 4" do
      conditional = nil
      @output.each do |line|
        conditional = line =~ /\s+<when\sexpression="4"\slevel="0"\/?>/
        break unless conditional.nil?
      end
      expect(conditional).not_to be_nil
    end

    it "Constructor: Find: if xpto1 == level1" do
      conditional = nil
      @output.each do |line|
        conditional = line =~ /\s+<if\sexpression="xpto1 == 'level1'"\slevel="1"\/?>/
        break unless conditional.nil?
      end
      expect(conditional).not_to be_nil
    end

    it "Constructor: Find: if xpto2 == level2" do
      conditional = nil
      @output.each do |line|
        conditional = line =~ /\s+<if\sexpression="xpto2 == 'level2'"\slevel="2"\/?>/
        break unless conditional.nil?
      end
      expect(conditional).not_to be_nil
    end

    it "Constructor: Find: if xpto3 == level3" do
      conditional = nil
      @output.each do |line|
        conditional = line =~ /\s+<if\sexpression="xpto3 == 'level3'"\slevel="3"\/?>/
        break unless conditional.nil?
      end
      expect(conditional).not_to be_nil
    end

    it "Constructor: Find: elsif abc == level3" do
      conditional = nil
      @output.each do |line|
        conditional = line =~ /\s+<elsif\sexpression="abc == 'level3'"\slevel="3"\/?>/
        break unless conditional.nil?
      end
      expect(conditional).not_to be_nil
    end

    it "Constructor: Find: elsif level3" do
      conditional = nil
      @output.each do |line|
        conditional = line =~ /\s+<else\slevel="3"\/?>/
        break unless conditional.nil?
      end
      expect(conditional).not_to be_nil
    end

    it "Constructor: Find: elsif banana == level1" do
      conditional = nil
      @output.each do |line|
        conditional = line =~ /\s+<elsif\sexpression="banana == 'level1'"\slevel="1"\/?>/
        break unless conditional.nil?
      end
      expect(conditional).not_to be_nil
    end

    it "Constructor: Find: when 7" do
      conditional = nil
      @output.each do |line|
        conditional = line =~ /\s+<when\sexpression="7"\slevel="0"\/?>/
        break unless conditional.nil?
      end
      expect(conditional).not_to be_nil
    end

    it "Constructor: Find: unless abc == level1" do
      conditional = nil
      @output.each do |line|
        conditional = line =~ /\s+<unless\sexpression="abc == 'level1'"\slevel="1"\/?>/
        break unless conditional.nil?
      end
      expect(conditional).not_to be_nil
    end

    it "Constructor: Find: if xpto == level2" do
      conditional = nil
      @output.each do |line|
        conditional = line =~ /\s+<if\sexpression="xpto == 'level2'"\slevel="2"\/?>/
        break unless conditional.nil?
      end
      expect(conditional).not_to be_nil
    end

    it "Constructor: Find: case x" do
      conditional = nil
      @output.each do |line|
        conditional = line =~ /\s+<case\sexpression="x"\slevel="3"\/?>/
        break unless conditional.nil?
      end
      expect(conditional).not_to be_nil
    end

    it "Constructor: Find: when 6" do
      conditional = nil
      @output.each do |line|
        conditional = line =~ /\s+<when\sexpression="6"\slevel="3"\/?>/
        break unless conditional.nil?
      end
      expect(conditional).not_to be_nil
    end

    it "Constructor: Find: when 7" do
      conditional = nil
      @output.each do |line|
        conditional = line =~ /\s+<when\sexpression="7"\slevel="3"\/?>/
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
