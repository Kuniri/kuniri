require_relative '../../../../lib/kuniri/core/kuniri'

RSpec.describe Kuniri::Kuniri do

  before :each do
    @path = "/spec/language/ruby/global_test/kuniri-config"
    @kuniri = Kuniri::Kuniri.new(@path)
  end

  it "Correct structure of class - Class" do
    #pLanguage ="**.rb"
    #@filesProject = Dir[File.join(@path, "**", pLanguage)]

    #@parser = Parser::Parser.new(@filesProject)
    #@parser.start_parser()
    @kuniri.run_analysis

    parser = Parser::XML.new
    parser.set_path("./spec/language/ruby/global_test/output_test.xml")
    parser.create_all_data @kuniri.get_parser()
  end

  after :each do
    
  end

end
