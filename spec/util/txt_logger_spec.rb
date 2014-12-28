require_relative '../spec_helper'

RSpec.describe Util::Txt_Logger do
  context "Write txt log" do

    before :all do
      @txt = Util::Txt_Logger.new("kuniri_log.txt")
      @txt.write_log("Text file log")
    end

    it "Create file" do
      expect(File.exists?("kuniri_log.txt")).to eq (true)
    end

    it "Write message" do
      message = Array.new
      File.open("kuniri_log.txt").each_line do |line|
        if line.include?("message:")
          message = line.split(':')
        end
      end
      expect(message[1]).to eq (" Text file log\n")
    end

    after :all do
      File.delete("kuniri_log.txt")
      @txt = nil
    end

  end
end
