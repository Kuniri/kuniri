require_relative 'spec_helper'

RSpec.describe Kuniri do

  def write_kuniri_file(parameter)
    File.open(".kuniri", 'w') do |file|
      file.write("language" + parameter[0])
      file.write("source" + parameter[1])
      file.write("output" + parameter[2])
      file.write("extract" + parameter[3])
    end
  end

  before :all do
    File.open(".kuniri", 'a') do |file|
      file.write("language:ruby")
      file.write("source:xpto")
      file.write("output:xpto/2")
      file.write("extract:uml,traceability")
    end
    @kuniri = Kuniri.new 
  end

  context "#read_configuration_file" do
    it "Wrong path" do
      expect(@kuniri.read_configuration_file("wrong/path")).to raise_error
    end

    it "Syntax error: not use ':'" do
      write_kuniri_file(["=ruby", ":../app/", ":./", ">uml"])
      expect(@kuniri.read_configuration_file(".kuniri")).to raise_error
    end

    it "Syntax error: not valid language" do
      write_kuniri_file([":k", ":../app/", ":./", ":uml"])
      expect(@kuniri.read_configuration_file(".kuniri")).to raise_error
    end

    it "Syntax error: wrong source directory" do
      write_kuniri_file([":ruby", ":xpto/", ":./", ":uml"])
      expect(@kuniri.read_configuration_file(".kuniri")).to raise_error
    end

    it "Syntax error: wrong output directory" do
      write_kuniri_file([":ruby", ":../app/", ":xpto/", ":uml"])
      expect(@kuniri.read_configuration_file(".kuniri")).to raise_error
    end
    
    it "Syntax error: wrong configuration file" do
      write_kuniri_file([":ruby", ":../app/", ":./", ":umg"])
      expect(@kuniri.read_configuration_file(".kuniri")).to raise_error
    end

    it "Correct return" do
      write_kuniri_file([":ruby", ":../app/", ":./", ":uml"])
      @kuniri.read_configuration_file(".kuniri").should include(
            "language" => "ruby", 
            "source_path" => "../app/", 
            "output" => "./", 
            "monitor" => "uml")
      write_kuniri_file([":ruBy", ":../app/", ":./", ":uMl, traCeaBilitY"])
      @kuniri.read_configuration_file(".kuniri").should include(
            "language" => "ruby",
            "source_path" => "../app/", 
            "output" => "./", 
            "monitor" => "uml")
    end
  end

  after :all do
    File.delete(".kuniri")
    @kuniri = nil
  end
end
