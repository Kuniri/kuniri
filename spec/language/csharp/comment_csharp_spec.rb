require_relative '../../spec_helper'

RSpec.describe Languages::Csharp::CommentCsharp do

  before :all do
    @csharpComment = Languages::Csharp::CommentCsharp.new
  end

  context "When it is a single line comment." do

    it "Simple case of single line comment." do
      comment = @csharpComment.get_comment("// Comment 1")
      expect(comment).to eq(" Comment 1")

      comment = @csharpComment.get_comment("// Comment number 2")
      expect(comment).to eq(" Comment number 2")
    end

    it "Comment with multiple spaces." do
      comment = @csharpComment.get_comment("              // Comment 1")
      expect(comment).to eq(" Comment 1")

      comment = @csharpComment.get_comment("      //       Comment 2")
      expect(comment).to eq("       Comment 2")
    end

    it "Check if is a single line comment." do
      comment = @csharpComment.is_single_line_comment?("  // Comment")
      expect(comment).to eq(true)

      comment = @csharpComment.is_single_line_comment?("          // Comment  ")
      expect(comment).to eq(true)

      comment = @csharpComment.is_single_line_comment?(" /*")
      expect(comment).to eq(false)
    end

    it "No comment." do
      comment = @csharpComment.get_comment("public class Xpto")
      expect(comment).to eq(nil)

      comment = @csharpComment.get_comment("private int value")
      expect(comment).to eq(nil)
    end

  end

  context "When it is a multiple line comment" do

    it "Simple case that indicates multiple line." do
      comment = @csharpComment.is_multiple_line_comment?("/*")
      expect(comment).to eq(true)

      comment = @csharpComment.is_multiple_line_comment?("      /*")
      expect(comment).to eq(false)

      comment = @csharpComment.is_multiple_line_comment?("              /* ")
      expect(comment).to eq(false) 
    end

    it "Find final of multiple line comment." do
      comment = @csharpComment.is_multiple_line_comment_end?(" */")
      expect(comment).to eq(false)

      comment = @csharpComment.is_multiple_line_comment_end?("*/")
      expect(comment).to eq(true)

      comment = @csharpComment.is_multiple_line_comment_end?("no")
      expect(comment).to eq(false)
    end

  end

  after :all do
    @csharpComment = nil
  end

end
