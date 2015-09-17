require_relative '../../../../lib/kuniri/core/kuniri'

RSpec.describe Kuniri::Kuniri do

  before :each do
    @path = "/spec/language/ruby/global_test/.kuniri"  
    @kuniri = Kuniri::Kuniri.new(@path)
  end

  it "Correct structure of class - Class" do
    pLanguage ="**.rb"
    @filesProject = Dir[File.join(@path, "**", pLanguage)]

    @parser = Parser::Parser.new(@filesProject)
    @parser.start_parser()

    parser = Parser::XML.new
    parser.create_all_data @kuniri.get_parser()
  end

  after :each do
    
  end

end