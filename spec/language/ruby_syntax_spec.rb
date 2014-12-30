require_relative '../spec_helper'

RSpec.describe Languages::RubySyntax do

  before :all do
    @sourceLines = Array.new
    File.open("ruby_support_test.rb", 'r') do |line|
      @sourceLines.push(line)
    end
    @rubySyntax = Languages::RubySyntax.new
  end

  context "#comment_extract" do 
    it "Total of comments" do 
      totalComments = @rubySyntax.comment_extract(@sourceLines).size
      expect(@rubySyntax.comment_extract(@sourceLines).size).to eq(6)
    end 

    it "Verify the correctness of the comment extracted" do
      firstCommentString = " RubySupportTest is used only for execute basic" 
      firstCommentString += " tests for check ruby syntax."
      comments = @rubySyntax.comment_extract(@sourceLines)
      expect(comments[1]).to eq(firstCommentString)
    end

    it "Multiple line comment" do
      multipleLineString =  "get_something is a method created for test the" 
      multipleLineString += " something...\n"
      multipleLineString += "The important thing here, is use of multiple"
      multipleLineString += " line.\n"
      comments = @rubySyntax.comment_extract(@sourceLines)
      expect(comments[5]).to eq(multipleLineString)
    end
  end

  context "#class_extract" do
    it "Class name" do
      classList = @rubySyntax.class_extract(@sourceLines)
      expect(classList.shift).to eq("RubySupportTest")
    end
  end

  context "#method_extract" do
    it "Method name" do
      methodName = @rubySyntax.method_extract(@sourceLines)
      expect(methodName.shift).to eq("get_something")
    end
  end

  after :all do
    @sourceLines = nil
  end
end
