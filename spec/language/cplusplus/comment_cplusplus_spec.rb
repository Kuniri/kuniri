require_relative '../../spec_helper'

RSpec.describe Languages::Cplusplus::CommentCplusplus do

  before :each do
    @cplusplusComment = Languages::Cplusplus::CommentCplusplus.new
  end

  context "When it is a single line comment." do
  	it "Simple case of single line comment." do
	  comment = @cplusplusComment.get_comment("// Comment 1")
	  expect(comment).to eq(" Comment 1")

	  comment = @cplusplusComment.get_comment("// Comment number 2")
	  expect(comment).to eq(" Comment number 2")
	end

     it "Comment with multiple spaces." do
      comment = @cplusplusComment.get_comment("              // Comment 1")
      expect(comment).to eq(" Comment 1")

      comment = @cplusplusComment.get_comment("      //       Comment 2")
      expect(comment).to eq("       Comment 2")
    end

    it "Check if is a single line comment." do
      comment = @cplusplusComment.is_single_line_comment?("  // Comment")
      expect(comment).to eq(true)

      comment = @cplusplusComment.is_single_line_comment?("          // Comment  ")
      expect(comment).to eq(true)

      comment = @cplusplusComment.is_single_line_comment?(" /*")
      expect(comment).to eq(false)

      comment = @cplusplusComment.is_single_line_comment?("/Comment/")
      expect(comment).to eq(false)

      comment = @cplusplusComment.is_single_line_comment?("/// Comment")
      expect(comment).to eq(true)
    end

    it "No comment." do
      comment = @cplusplusComment.get_comment("class Xpto")
      expect(comment).to eq(nil)

      comment = @cplusplusComment.get_comment("@value")
      expect(comment).to eq(nil)
    end
  end

  context "When it is a multiple line comment" do

    it "Simple case that indicates multiple line." do
      comment = @cplusplusComment.is_multiple_line_comment?("/*")
      expect(comment).to eq(true)

      comment = @cplusplusComment.is_multiple_line_comment?("      /*")
      expect(comment).to eq(true)

      comment = @cplusplusComment.is_multiple_line_comment?("              /* ")
      expect(comment).to eq(true)
    end

    it "Find final of multiple line comment." do
      comment = @cplusplusComment.is_multiple_line_comment_end?(" */")
      expect(comment).to eq(true)

      comment = @cplusplusComment.is_multiple_line_comment_end?(" */ ")
      expect(comment).to eq(true)

      comment = @cplusplusComment.is_multiple_line_comment_end?("no")
      expect(comment).to eq(false)
    end

  end

  after :each do
    @cplusplusComment = nil
  end

end
