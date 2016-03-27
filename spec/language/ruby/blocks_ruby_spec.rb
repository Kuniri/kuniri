require_relative '../../spec_helper'

RSpec.describe Languages::Ruby::BlocksRuby do

  before :each do
    @blockRuby = Languages::Ruby::BlocksRuby.new
  end

  context "Simple block detection:" do
    it "Detect each" do
      captured = @blockRuby.get_blocks("xpto.each do |y|")
      expect(captured.name).to eq("EACH")
    end

    it "Detect map" do
      captured = @blockRuby.get_blocks("xpto.map do |y|")
      expect(captured.name).to eq("MAP")
    end

    it "Detect each" do
      captured = @blockRuby.get_blocks("xpto.collect do |y|")
      expect(captured.name).to eq("COLLECT")
    end

    it "Detect delete if" do
      captured = @blockRuby.get_blocks("xpto.delete_if do |y|")
      expect(captured.name).to eq("DELETE_IF")
    end

    it "Detect delete at" do
      captured = @blockRuby.get_blocks("xpto.delete_at do |y|")
      expect(captured.name).to eq("DELETE_AT")
    end

    it "Detect each with index" do
      captured = @blockRuby.get_blocks("xpto.each_with_index do |y|")
      expect(captured.name).to eq("EACH_WITH_INDEX")
    end

    it "Detect each with as attribute" do
      captured = @blockRuby.get_blocks("@xpto.each_with_index do |y|")
      expect(captured.name).to eq("EACH_WITH_INDEX")
    end

    it "Detect each with as class object" do
      captured = @blockRuby.get_blocks("@@xpto.each_with_index do |y|")
      expect(captured.name).to eq("EACH_WITH_INDEX")
    end

  end

  context "Check different situations:" do
    it "Check block with white space in the beginning" do
      captured = @blockRuby.get_blocks("xpto.              each do |y|")
      expect(captured.name).to eq("EACH")
    end

    it "Check block with white space at the end" do
      captured = @blockRuby.get_blocks("xpto.each      do    |u|    ")
      expect(captured.name).to eq("EACH")
    end

    it "Check block with white space between parameters" do
      captured = @blockRuby.get_blocks("xpto.map do |         uuuu         |")
      expect(captured.name).to eq("MAP")
    end

    it "Check block with multiple white spaces" do
      captured = @blockRuby.get_blocks("    xpto .  collect    do  |u | ")
      expect(captured.name).to eq("COLLECT")
    end

    it "Nested access" do
      captured = @blockRuby.get_blocks("lalala.huehue.xpto.each do |y|")
      expect(captured.name).to eq("EACH")
    end

  end

  context "Should not detect:" do
    it "Only iterator" do
      captured = @blockRuby.get_blocks("each do |y|")
      expect(captured).to eq(nil)
    end

    it "Only full syntax" do
      captured = @blockRuby.get_blocks("xpto.each do")
      expect(captured).to eq(nil)
    end

    it "Syntax error with '|'" do
      captured = @blockRuby.get_blocks("xpto..each do |x")
      expect(captured).to eq(nil)
    end

    it "Syntax error with ','" do
      captured = @blockRuby.get_blocks("xpto,each do |x|")
      expect(captured).to eq(nil)
    end

    it "Code inside quotas" do
      captured = @blockRuby.get_blocks("'xpto,each do |x|'")
      expect(captured).to eq(nil)
    end


  end

  after :each do
    @blockRuby = nil
  end

end
