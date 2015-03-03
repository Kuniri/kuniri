require_relative '../spec_helper'

RSpec.describe Parser::Parser do

  before :each do
    @filesProject = Dir[File.join("./", "**", "**.rb")]
    @parser = Parser::Parser.new(@filesProject)
  end

  context "When start, find all the ruby files" do
    it "Always get a list" do
      expect(@parser.get_object_files).to eq([])
    end

    it "Total of files to parse" do
      @parser.start_parser
      expect(@parser.get_object_files.size).to eq(@filesProject.size)
    end
  end

  after :each do
    @parser = nil
  end

end
