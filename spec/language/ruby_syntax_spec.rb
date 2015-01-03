require_relative '../spec_helper'

RSpec.describe Languages::RubySyntax do

  before :all do
    file = File.open("spec/language/ruby_support_test.rb", "rb")
    @rubySyntax = Languages::RubySyntax.new
    @rubySyntax.set_source(file.read)
  end

  context "#comment_extract" do 
    it "Total of comments" do 
      totalComments = @rubySyntax.comment_extract.size
      expect(@rubySyntax.comment_extract.size).to eq(7)
    end 

    it "Verify the correctness of the comment extracted" do
      firstCommentString = " RubySupportTest is used only for execute basic" 
      firstCommentString += " tests for check ruby syntax."
      comments = @rubySyntax.comment_extract
      expect(comments[1]).to eq(firstCommentString)
    end

    it "Multiple line comment" do
      multipleLineString =  "get_something is a method created for test the" 
      multipleLineString += " something...\n"
      multipleLineString += " The important thing here, is use of multiple"
      multipleLineString += " line.\n"
      comments = @rubySyntax.comment_extract
      expect(comments[6]).to eq(multipleLineString)
    end
  end

  context "#class_extract" do
    it "Class name" do
      classList = @rubySyntax.class_extract
      expect(classList.shift).to eq(["RubySupportTest"])
    end
  end

  context "#method_extract" do
    it "Method name" do
      methodName = @rubySyntax.method_extract
      expect(methodName.shift).to eq("get_something")
    end
  end

  after :all do
    @sourceLines = nil
  end
end
