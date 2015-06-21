require_relative '../../spec_helper'

RSpec.describe Languages::Ruby::EndBlockRuby do

  before :all do
    @endBlock = Languages::Ruby::EndBlockRuby.new
  end

  context "When the end of block is isolate in one line." do
    it "No end in the line" do
      isEnd = @endBlock.has_end_of_block?("class Xpto")
      expect(isEnd).to eq(false)
    end

    it "Find simple situation of end." do
      isEnd = @endBlock.has_end_of_block?("end")
      expect(isEnd).to eq(true)
    end

    it "Find end of block with spaces in the begin." do
      isEnd = @endBlock.has_end_of_block?("     end")
      expect(isEnd).to eq(true)
      isEnd = @endBlock.has_end_of_block?(" end")
      expect(isEnd).to eq(true)
      isEnd = @endBlock.has_end_of_block?("                             end")
      expect(isEnd).to eq(true)
    end

    it "Find end of block with space after." do
      isEnd = @endBlock.has_end_of_block?("end          ")
      expect(isEnd).to eq(true)
      isEnd = @endBlock.has_end_of_block?("end ")
      expect(isEnd).to eq(true)
      isEnd = @endBlock.has_end_of_block?("end               ")
      expect(isEnd).to eq(true)
    end

    it "Find end of block with space in the begin and in the end." do
      isEnd = @endBlock.has_end_of_block?("     end          ")
      expect(isEnd).to eq(true)
      isEnd = @endBlock.has_end_of_block?("       end ")
      expect(isEnd).to eq(true)
      isEnd = @endBlock.has_end_of_block?(" end    ")
      expect(isEnd).to eq(true)
      isEnd = @endBlock.has_end_of_block?(" end ")
      expect(isEnd).to eq(true)
      isEnd = @endBlock.has_end_of_block?("     end     ")
      expect(isEnd).to eq(true)
    end

  end

  #context "end in the same line of other instructions" do
  # TODO: This is the hardest cases. Do it!
  #end

  after :all do
    @endBlock = nil
  end

end

