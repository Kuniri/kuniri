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
    it "Simple class inheritance." do
      classNameCaptured = @classRuby.get_class("class Xpto < Abc").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class inheritance with whitespace in the beginning." do
      classNameCaptured = @classRuby.get_class("     class   Xpto < Abc").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class inheritance with whitespace between <." do
      classNameCaptured = @classRuby.get_class("class Xpto   < Abc").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class inheritance with many whitespace." do
      classNameCaptured = @classRuby.get_class("   class   Xpto < Abc ").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class inheritance with many whitespace between <." do
      classNameCaptured = @classRuby.get_class("class Xpto      <    Abc").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class inheritance with whitespace in the corners." do
      classNameCaptured = @classRuby.get_class("  class   Xpto < Abc   ").name
      expect(classNameCaptured).to eq("Xpto")
    end
  end

  after :all do
    @classRuby = nil
  end

end
