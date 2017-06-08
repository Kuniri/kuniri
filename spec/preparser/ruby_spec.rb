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

  context "Multiple-line comments" do
    it "Extracts simple multiple line comments" do
      lines = [{code: "def a", comment: nil },
               {code: "  puts(\"test\")", comment: nil },
               {code: "end", comment: nil },
               {code: "=begin", comment: nil },
               {code: "a", comment: nil },
               {code: "beautiful", comment: nil },
               {code: "comment", comment: nil },
               {code: "yeah", comment: nil },
               {code: "!!!", comment: nil },
               {code: "=end", comment: nil }]
      pre_parsed_lines = @pre_parser.get_multiple_lines_comment(lines)
      expect(pre_parsed_lines[3][:comment]).to eq "a beautiful comment yeah !!! "
    end

    it "Extracts multiple line comments with comment after =begin" do
      lines = [{code: "def a", comment: nil },
               {code: "  puts(\"test\")", comment: nil },
               {code: "end", comment: nil },
               {code: "=begin after begin", comment: nil },
               {code: "a", comment: nil },
               {code: "beautiful", comment: nil },
               {code: "comment", comment: nil },
               {code: "yeah", comment: nil },
               {code: "!!!", comment: nil },
               {code: "=end", comment: nil }]
      pre_parsed_lines = @pre_parser.get_multiple_lines_comment(lines)
      expect(pre_parsed_lines[3][:comment]).to eq "after begin a beautiful comment yeah !!! "
    end

    it "Extracts 2 multiple line comments" do
      lines = [{code: "def a", comment: nil },
               {code: "  puts(\"test\")", comment: nil },
               {code: "end", comment: nil },
               {code: "=begin after begin", comment: nil },
               {code: "a", comment: nil },
               {code: "beautiful", comment: nil },
               {code: "comment", comment: nil },
               {code: "yeah", comment: nil },
               {code: "!!!", comment: nil },
               {code: "=end", comment: nil },
               {code: "c = 2", comment: nil},
               {code: "=begin", comment:nil},
               {code: "second", comment:nil},
               {code: "comment", comment:nil},
               {code: "=end", comment:nil}]

      pre_parsed_lines = @pre_parser.get_multiple_lines_comment(lines)
      first_comment = pre_parsed_lines[3][:comment] == "after begin a beautiful comment yeah !!! "
      second_comment = pre_parsed_lines[5][:comment] == "second comment "
      expect(first_comment && second_comment).to be true
    end
  end
  
end

