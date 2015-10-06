require_relative '../../spec_helper'

RSpec.describe Languages::Cplusplus::CommentCplusplus do

  before :all do
    @cplusplusComment = Languages::Cplusplus::CommentCplusplus.new
  end

  after :all do
    @cplusplusComment = nil
  end

end
