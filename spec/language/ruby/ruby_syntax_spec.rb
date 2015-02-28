require_relative '../../spec_helper'

RSpec.describe Languages::RubySyntax do

  before :each do
    # It must to be changed!!!
    file = File.open("spec/language/ruby/ruby_support_test.rb", "rb")
    @rubySyntax = Languages::RubySyntax.new
    @rubySyntax.set_source(file.read)

    file = File.open("spec/language/ruby/rubyBasicSyntaxTest.txt", "rb")
    @rubySyntax2 = Languages::RubySyntax.new
    @rubySyntax2.set_source(file.read)
  end

  context "#comment_extract" do
    it "Total of comments" do
      totalComments = @rubySyntax.comment_extract.size
      expect(@rubySyntax.comment_extract.size).to eq(7)
    end

    it "Comment systax: Correctness" do
      first = "This file configures a basic test of"
      first += " ruby syntax. It is no intend to work."
      comment = @rubySyntax2.comment_extract
      expect(comment.shift).to eq(first)

      second = " The basic ideia is verify if kuniri extract the necessary "
      second += "code in the "
      expect(comment.shift).to eq(second)

      third = "correct way."
      expect(comment.shift).to eq(third)

      fourth = "Test xpto class"
      expect(comment.shift).to eq(fourth)

      fifth = "something"
      expect(comment.shift).to eq(fifth)

      sixth = " construct"
      expect(comment.shift).to eq(sixth)

      seventh = "Code..."
      expect(comment.shift).to eq(seventh)

      eighth = "... code ..."
      expect(comment.shift).to eq(eighth)

      nine = "function 3"
      expect(comment.shift).to eq(nine)

      fourth = "1: Right!\n"
      expect(comment.shift).to eq(fourth)

      sixth = "2: Right!\n"
      expect(comment.shift).to eq(sixth)
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

#  context "#class_extract" do
#    it "Class name" do
#      classList = @rubySyntax.class_extract
#      expect(classList.name).to eq("RubySupportTest")
#
#      classList2 = @rubySyntax2.class_extract
#      expect(classList2.name).to eq("Class1GetRight")
#      expect(classList2.name).to eq("Class2GetRight")
#      expect(classList2.name).to eq("Class3GetRight")
#      expect(classList2.name).to eq("Class4MethodTest")
#    end
#  end

#  context "#method_extract" do
#    it "Method name" do
#      methodName = @rubySyntax.method_extract
#      first = methodName.shift
#      expect(first.name).to eq("initialize")
#
#      methodName2 = @rubySyntax.method_extract
#      expect(methodName2.shift.name).to eq("firstMethodRight")
#      methodParameter = methodName2.shift.name
#      expect(methodParameter.name).to eq("secondMethodRight")
#      expect(methodParameter.parameter[0]).to eq("one")
#      expect(methodParameter.parameter[1]).to eq("two")
#      expect(methodParameter.parameter[2]).to eq("three")
#    end
#  end

  after :each do
    @sourceLines = nil
  end
end
