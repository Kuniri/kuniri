require_relative '../../spec_helper'

RSpec.describe Languages::Ruby::ClassRuby do

  before :all do 
    @classRuby = Languages::Ruby::ClassRuby.new
  end

  context "When is class without inheritance" do
    it "Ordinary class declaration." do
      classNameCaptured = @classRuby.get_class("class Xpto").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class declaration with whitespace." do
      classNameCaptured = @classRuby.get_class("     class      Xpto").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class declaration between whitespace." do
      classNameCaptured = @classRuby.get_class("     class      Xpto   ").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class declaration with whitespace in the beginning." do
      classNameCaptured = @classRuby.get_class("        class Xpto").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class declaration with whitespace in the end." do
      classNameCaptured = @classRuby.get_class("class Xpto        ").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class declaration delimited by whitespace." do
      classNameCaptured = @classRuby.get_class("  class  Xpto      ").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class declaration with a few whitespace." do
      classNameCaptured = @classRuby.get_class(" class Xpto  ").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class declaration with whitespace in the beginning." do
      classNameCaptured = @classRuby.get_class(" class Xpto").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class declaration ended with whitespace." do
      classNameCaptured = @classRuby.get_class("class  Xpto  ").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class declaration with many whitespace." do
      classNameCaptured = @classRuby.get_class(" class  Xpto ").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class declaration with tab." do
      classNameCaptured = @classRuby.get_class("    class  Xpto  ").name
      expect(classNameCaptured).to eq("Xpto")
    end
  end

  context "When with inheritance" do
    it "Simple class name w/ inheritance." do
      classNameCaptured = @classRuby.get_class("class Xpto < Abc").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Simple class inheritance." do
      classNameCaptured = @classRuby.get_class("class Xpto < Abc").inheritances
      expect(classNameCaptured).to eq([["Abc"]])
    end

    it "Class name w/ inheritance with whitespace in the beginning." do
      classNameCaptured = @classRuby.get_class("     class   Xpto < Abc").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class inheritance with whitespace in the beginning." do
      classNameCaptured = @classRuby.get_class("     class   Xpto < Abc")
                                    .inheritances
      expect(classNameCaptured).to eq([["Abc"]])
    end

    it "Class name w/ inheritance with whitespace between <." do
      classNameCaptured = @classRuby.get_class("class Xpto   < Abc").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class inheritance with whitespace between <." do
      classNameCaptured = @classRuby.get_class("class Xpto   < Abc")
                                    .inheritances
      expect(classNameCaptured).to eq([["Abc"]])
    end

    it "Class name w/ inheritance with many whitespace." do
      classNameCaptured = @classRuby.get_class("   class   Xpto < Abc ").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class inheritance with many whitespace." do
      classNameCaptured = @classRuby.get_class("   class   Xpto < Abc ")
                                    .inheritances
      expect(classNameCaptured).to eq([["Abc"]])
    end

    it "Class name w/ inheritance with many whitespace between <." do
      classNameCaptured = @classRuby.get_class("class Xpto      <    Abc").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class inheritance with many whitespace between <." do
      classNameCaptured = @classRuby.get_class("class Xpto      <    Abc")
                                    .inheritances
      expect(classNameCaptured).to eq([["Abc"]])
    end

    it "Class name w/ inheritance with whitespace in the corners." do
      classNameCaptured = @classRuby.get_class("  class   Xpto < Abc   ").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class inheritance with whitespace in the corners." do
      classNameCaptured = @classRuby.get_class("  class   Xpto < Abc   ")
                                    .inheritances
      expect(classNameCaptured).to eq([["Abc"]])
    end
  end

  context "Get inheritance" do

    it "Class inheritance normal case" do
      inheritance = @classRuby.get_class("class Xpto < Abc").inheritances[0]
      expect(inheritance).to eq(["Abc"])
    end

    it "Inheritance with many spaces in the beginning" do
      inheritance = @classRuby.get_class("class Xpto <    Abc").inheritances[0]
      expect(inheritance).to eq(["Abc"])
    end

    it "Inheritance with many spaces in the end" do
      inheritance = @classRuby.get_class("class Xpto < Abc   ").inheritances[0]
      expect(inheritance).to eq(["Abc"])
    end

    it "Inheritance with many spaces in the beginning and in the end" do
      inheritance = @classRuby.get_class("class Xs <   Abc   ").inheritances[0]
      expect(inheritance).to eq(["Abc"])

    end

  end

  after :all do
    @classRuby = nil
  end

end
