require_relative '../../spec_helper'

RSpec.describe Languages::Cplusplus::ClassCplusplus do

  before :all do
    @classCplusplus = Languages::Cplusplus::ClassCplusplus.new
  end

  context "When is class without inheritance" do
    it "Ordinary class declaration." do
      classNameCaptured = @classCplusplus.get_class("class Xpto").name
      expect(classNameCaptured).to eq("Xpto")
    end
    it "Class declaration with whitespace." do
      classNameCaptured = @classCplusplus.get_class("     class      Xpto").name
      expect(classNameCaptured).to eq("Xpto")
    end
    it "Class declaration between whitespace." do
      classNameCaptured = @classCplusplus.get_class("     class      Xpto   ").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class declaration with whitespace in the beginning." do
      classNameCaptured = @classCplusplus.get_class("        class Xpto").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class declaration with whitespace in the end." do
      classNameCaptured = @classCplusplus.get_class("class Xpto        ").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class declaration delimited by whitespace." do
      classNameCaptured = @classCplusplus.get_class("  class  Xpto      ").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class declaration with a few whitespace." do
      classNameCaptured = @classCplusplus.get_class(" class Xpto  ").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class declaration with whitespace in the beginning." do
      classNameCaptured = @classCplusplus.get_class(" class Xpto").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class declaration ended with whitespace." do
      classNameCaptured = @classCplusplus.get_class("class  Xpto  ").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class declaration with many whitespace." do
      classNameCaptured = @classCplusplus.get_class(" class  Xpto ").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class declaration with tab." do
      classNameCaptured = @classCplusplus.get_class("    class  Xpto  ").name
      expect(classNameCaptured).to eq("Xpto")
    end
  end

  context "When with inheritance" do
    it "Simple class public inheritance." do
      classNameCaptured = @classCplusplus.get_class("class Xpto : public Abc").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Simple class protected inheritance." do
      classNameCaptured = @classCplusplus.get_class("class Xpto : protected Abc").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Simple class private inheritance." do
      classNameCaptured = @classCplusplus.get_class("class Xpto : private Abc").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class inheritance with whitespace in the beginning." do
      classNameCaptured = @classCplusplus.get_class("     class   Xpto : public Abc").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class inheritance with whitespace between : protected." do
      classNameCaptured = @classCplusplus.get_class("class Xpto   : protected Abc").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class inheritance with many whitespace." do
      classNameCaptured = @classCplusplus.get_class("   class   Xpto : public Abc ").name
      expect(classNameCaptured).to eq("Xpto")
    end

  end


  after :all do
    @classCplusplus = nil
  end

end
