require_relative '../spec_helper'

RSpec.describe Util::HtmlLogger do
  context "Write html log" do 
    
    before :all do
      @html = Util::HtmlLogger.new("log.html")
      @html.write_log("HTML log")
    end

    it "Create file" do 
      expect(File.exists?("log.html")).to eq (true)
    end

    it "Write message" do
      message = Array.new
      File.open("log.html").each_line do |line|
        if line.include?("<i>")
          message = line
        end
      end
      expect(message).to eq ("\t<i>HTML log</i>\n")
    end

    after :all do
      File.delete("log.html")
      @html = nil
    end

  end 
end
