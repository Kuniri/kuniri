require_relative '../../spec_helper'

RSpec.describe Languages::Ruby::CommentRuby do

  before :all do
    @rubyComment = Languages::Ruby::CommentRuby.new
  end

  context 'When it is a single line comment.' do

    it 'Simple case of single line comment.' do
      comment = @rubyComment.get_comment('# Comment 1')
      expect(comment).to eq(' Comment 1')

      comment = @rubyComment.get_comment('# Comment number 2')
      expect(comment).to eq(' Comment number 2')
    end

    it 'Comment with multiple spaces.' do
      comment = @rubyComment.get_comment('              # Comment 1')
      expect(comment).to eq(' Comment 1')

      comment = @rubyComment.get_comment('      #       Comment 2')
      expect(comment).to eq('       Comment 2')
    end

    it 'Check if is a single line comment.' do
      comment = @rubyComment.single_line_comment?('  # Comment')
      expect(comment).to eq(true)

      comment = @rubyComment.single_line_comment?('          # Comment  ')
      expect(comment).to eq(true)

      comment = @rubyComment.single_line_comment?(' =begin')
      expect(comment).to eq(false)
    end

    it 'No comment.' do
      comment = @rubyComment.get_comment('class Xpto')
      expect(comment).to eq(nil)

      comment = @rubyComment.get_comment('@value')
      expect(comment).to eq(nil)
    end

  end

  context 'When it is a multiple line comment' do

    it 'Simple case that indicates multiple line.' do
      comment = @rubyComment.multiple_line_comment?('=begin')
      expect(comment).to eq(true)

      comment = @rubyComment.multiple_line_comment?('      =begin')
      expect(comment).to eq(false)

      comment = @rubyComment.multiple_line_comment?('              =begin ')
      expect(comment).to eq(false) 
    end

    it 'Find final of multiple line comment.' do
      comment = @rubyComment.multiple_line_comment_end?(' =end')
      expect(comment).to eq(false)

      comment = @rubyComment.multiple_line_comment_end?('=end')
      expect(comment).to eq(true)

      comment = @rubyComment.multiple_line_comment_end?('no')
      expect(comment).to eq(false)
    end

  end

  after :all do
    @rubyComment = nil
  end

end
