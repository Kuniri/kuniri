require_relative 'spec_helper'
require_relative '../app/error/configuration_file_error'

RSpec.describe Kuniri do

  def write_kuniri_file(parameter)
    File.open(".kuniri", 'w') do |file|
      file.write("language" + parameter[0] + "\n")
      file.write("source" + parameter[1] + "\n")
      file.write("output" + parameter[2] + "\n")
      file.write("extract" + parameter[3] + "\n")
    end
  end

  before :all do
    File.open(".kuniri", 'a') do |file|
      file.write("language:ruby" + "\n")
      file.write("source:xpto" + "\n")
      file.write("output:xpto/2" + "\n")
      file.write("extract:uml,traceability" + "\n")
    end
    @kuniri = Kuniri.new 
  end

  context "#read_configuration_file" do
    it "Wrong path" do
      expect{@kuniri.read_configuration_file("wrong/path")}.to raise_error(
        Error::Configuration_file_error)
    end

    it "Syntax error: not use ':'" do
      write_kuniri_file(["=ruby", ":../app/", ":./", ">uml"])
      expect{@kuniri.read_configuration_file(".kuniri")}.to raise_error(
        Error::Configuration_file_error)
    end

    it "Syntax error: not valid language" do
      write_kuniri_file([":k", ":../app/", ":./", ":uml"])
      expect{@kuniri.read_configuration_file(".kuniri")}.to raise_error(
        Error::Configuration_file_error)
    end

    it "Syntax error: wrong source directory" do
      write_kuniri_file([":ruby", ":xpto/", ":./", ":uml"])
      expect{@kuniri.read_configuration_file(".kuniri")}.to raise_error(
        Error::Configuration_file_error)
    end

    it "Syntax error: wrong output directory" do
      write_kuniri_file([":ruby", ":../app/", ":xpto/", ":uml"])
      expect{@kuniri.read_configuration_file(".kuniri")}.to raise_error(
        Error::Configuration_file_error)
    end
    
    it "Syntax error: wrong extract" do
      write_kuniri_file([":ruby", ":../app/", ":./", ":umg"])
      expect{@kuniri.read_configuration_file(".kuniri")}.to raise_error(
        Error::Configuration_file_error)
    end

    it "Correct return" do
      write_kuniri_file([":ruby", ":../app/", ":./", ":uml"])
      expect(@kuniri.read_configuration_file(".kuniri")).to include(
            "language" => "ruby", 
            "source" => "../app/", 
            "output" => "./", 
            "extract" => "uml")
      write_kuniri_file([":ruBy", ":../app/", ":./", ":uMl, traCeaBilitY"])
      expect(@kuniri.read_configuration_file(".kuniri")).to include(
            "language" => "ruby",
            "source" => "../app/", 
            "output" => "./", 
            "extract" => "uml,traceability")
    end
  end

  after :all do
    File.delete(".kuniri")
    @kuniri = nil
  end
end
