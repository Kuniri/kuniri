require_relative '../../spec_helper'

RSpec.describe Languages::Cplusplus::EndBlockCplusplus do

  before :all do
    @endBlock = Languages::Cplusplus::EndBlockCplusplus.new
  end

  context "When the end of block is isolate in one line." do
    it "No end in the line" do
      isEnd = @endBlock.has_end_of_block?("class Xpto")
      expect(isEnd).to eq(false)
    end

    it "Find simple situation of end." do
      isEnd = @endBlock.has_end_of_block?("}")
      expect(isEnd).to eq(true)
    end

    it "Find end of block with spaces in the begin." do
      isEnd = @endBlock.has_end_of_block?("     }")
      expect(isEnd).to eq(true)
      isEnd = @endBlock.has_end_of_block?(" }")
      expect(isEnd).to eq(true)
      isEnd = @endBlock.has_end_of_block?("                             }")
      expect(isEnd).to eq(true)
    end

    it "Find end of block with space after." do
      isEnd = @endBlock.has_end_of_block?("}          ")
      expect(isEnd).to eq(true)
      isEnd = @endBlock.has_end_of_block?("} ")
      expect(isEnd).to eq(true)
      isEnd = @endBlock.has_end_of_block?("}               ")
      expect(isEnd).to eq(true)
    end

    it "Find end of block with space in the begin and in the end." do
      isEnd = @endBlock.has_end_of_block?("     }          ")
      expect(isEnd).to eq(true)
      isEnd = @endBlock.has_end_of_block?("       } ")
      expect(isEnd).to eq(true)
      isEnd = @endBlock.has_end_of_block?(" }    ")
      expect(isEnd).to eq(true)
      isEnd = @endBlock.has_end_of_block?(" } ")
      expect(isEnd).to eq(true)
      isEnd = @endBlock.has_end_of_block?("     }     ")
      expect(isEnd).to eq(true)
    end

    it "Find end of block when the whole method is in one line." do
       isEnd = @endBlock.has_end_of_block?("void Xpto::xpto_method()
       	printf(\"Hello\") }")
       expect(isEnd).to eq(true)
       isEnd = @endBlock.has_end_of_block?("void Xpto::xpto_method()
       	printf(\"Hello\");}")
       expect(isEnd).to eq(true)
       isEnd = @endBlock.has_end_of_block?("void Xpto::xpto_method()
       	printf(\"Hello\")};")
       expect(isEnd).to eq(false)
       isEnd = @endBlock.has_end_of_block?("void Xpto::xpto_method()
       	printf(\"Hello}\");")
       expect(isEnd).to eq(false)
    end

  end

  after :all do
    @endBlock = nil
  end

end

