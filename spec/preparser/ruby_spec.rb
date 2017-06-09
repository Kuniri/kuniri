require_relative '../spec_helper'


RSpec.describe Object do

  before :all do
    @pre_parser = RubyPreParser.new
  end


  context "zip multiple lines" do
    it "Multiple-line function declaration" do
      multi_line_function = ["def foo(a,","b,","c)"]
      zipped_function = @pre_parser.zip_multiple_lines_command(multi_line_function)
      expect(zipped_function).to eq ["def foo(a,b,c)"]
    end
    it "Multiple-line method chaining" do
      multi_line_chain = ["foo.", "a.", "b"]
      zipped_chain = @pre_parser.zip_multiple_lines_command(multi_line_chain)
      expect(zipped_chain).to eq ["foo.a.b"]
    end
    it "Multiple-line function with one new line per parameter" do
      multi_line_function = ["def foo(", "a,","b,","c)"]
      zipped_function = @pre_parser.zip_multiple_lines_command(multi_line_function)
      expect(zipped_function).to eq ["def foo(a,b,c)"]
    end
  end
  
end

