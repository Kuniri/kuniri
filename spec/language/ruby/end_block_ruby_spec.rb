require_relative '../../spec_helper'

RSpec.describe Languages::Ruby::EndBlockRuby do

  before :all do
    @endBlock = Languages::Ruby::EndBlockRuby.new
  end

  context "When the end of block is isolate in one line." do
    it "No end in the line" do
      isEnd = @endBlock.end_of_block?("class Xpto")
      expect(isEnd).to eq(false)
    end

    it "Find simple situation of end." do
      isEnd = @endBlock.end_of_block?("end")
      expect(isEnd).to eq(true)
    end

    it "Find end of block with spaces in the begin." do
      isEnd = @endBlock.end_of_block?("     end")
      expect(isEnd).to eq(true)
      isEnd = @endBlock.end_of_block?(" end")
      expect(isEnd).to eq(true)
      isEnd = @endBlock.end_of_block?("                             end")
      expect(isEnd).to eq(true)
    end

    it "Find end of block with space after." do
      isEnd = @endBlock.end_of_block?("end          ")
      expect(isEnd).to eq(true)
      isEnd = @endBlock.end_of_block?("end ")
      expect(isEnd).to eq(true)
      isEnd = @endBlock.end_of_block?("end               ")
      expect(isEnd).to eq(true)
    end

    it "Find end of block with space in the begin and in the end." do
      isEnd = @endBlock.end_of_block?("     end          ")
      expect(isEnd).to eq(true)
      isEnd = @endBlock.end_of_block?("       end ")
      expect(isEnd).to eq(true)
      isEnd = @endBlock.end_of_block?(" end    ")
      expect(isEnd).to eq(true)
      isEnd = @endBlock.end_of_block?(" end ")
      expect(isEnd).to eq(true)
      isEnd = @endBlock.end_of_block?("     end     ")
      expect(isEnd).to eq(true)
    end

    it "Find end of block when the whole method is in one line." do
       isEnd = @endBlock.end_of_block?("def subtract(a,b) a-b end")
       expect(isEnd).to eq(true)
       isEnd = @endBlock.end_of_block?("def subtract(a,b) a-b friend")
       expect(isEnd).to eq(false)
       isEnd = @endBlock.end_of_block?("def subtract(a,b) a-b endless")
       expect(isEnd).to eq(false)
       isEnd = @endBlock.end_of_block?("def sum(a,b) a+b end;")
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

