require_relative '../../spec_helper'

RSpec.describe Languages::CplusplusSyntax do

  before :each do
    @syntax = Languages::CplusplusSyntax.new
  end

  after :each do
    @syntax = nil
  end

end
