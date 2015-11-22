require_relative '../../spec_helper'

RSpec.describe Languages::Java::ClassJava do

  before :all do 
    @classJava = Languages::Java::ClassJava.new
  end

  context "When is class without inheritance" do
    it "Ordinary class declaration." do
      classNameCaptured = @classJava.get_class("class Xpto").name
      expect(classNameCaptured).to eq("Xpto")
    
      classNameCaptured = @classJava.get_class("public class Xpto").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classJava.get_class("private class Xpto").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classJava.get_class("protected class Xpto").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class declaration with abstract modifier" do
      classNameCaptured = @classJava.get_class("abstract class Xpto").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classJava.get_class("public abstract class Xpto").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classJava.get_class("private abstract class Xpto").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classJava.get_class("protected abstract class Xpto").name
      expect(classNameCaptured).to eq("Xpto")

    end
          
    it "Class declaration with static modifier" do
      classNameCaptured = @classJava.get_class("static class Xpto").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classJava.get_class("public static class Xpto").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classJava.get_class("private static class Xpto").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classJava.get_class("protected static class Xpto").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class declaration with final modifier" do
      classNameCaptured = @classJava.get_class("final class Xpto").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classJava.get_class("public final class Xpto").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classJava.get_class("private final class Xpto").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classJava.get_class("protected final class Xpto").name
      expect(classNameCaptured).to eq("Xpto")
    end
  

    it "Class declaration with whitespace." do
      classNameCaptured = @classJava.get_class("public     class      Xpto").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class declaration between whitespace." do
      classNameCaptured = @classJava
        .get_class("     public     class      Xpto   ").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class declaration with whitespace in the beginning." do
      classNameCaptured = @classJava.get_class("       public class Xpto").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class declaration with whitespace in the end." do
      classNameCaptured = @classJava.get_class("public class Xpto        ").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class declaration delimited by whitespace." do
      classNameCaptured = @classJava.get_class("  public  class  Xpto      ").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class declaration with a few whitespace." do
      classNameCaptured = @classJava.get_class(" public class Xpto  ").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class declaration with whitespace in the beginning." do
      classNameCaptured = @classJava.get_class(" public class Xpto").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class declaration ended with whitespace." do
      classNameCaptured = @classJava.get_class("public  class  Xpto  ").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class declaration with many whitespace." do
      classNameCaptured = @classJava.get_class("  public class  Xpto ").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class declaration with tab." do
      classNameCaptured = @classJava.get_class("    public class  Xpto  ").name
      expect(classNameCaptured).to eq("Xpto")
    end
  end

  context "When with inheritance" do
    it "Simple class inheritance." do
      classNameCaptured = @classJava.get_class("class Xpto extends Abc").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classJava.get_class("public class Xpto extends Abc").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classJava.get_class("private class Xpto extends Abc").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classJava.get_class("protected class Xpto extends Abc").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class inheritance with whitespace in the beginning." do
      classNameCaptured = @classJava.get_class("     class Xpto extends Abc").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classJava.get_class("     public class Xpto extends Abc").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classJava.get_class("     private class Xpto extends Abc").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classJava.get_class("     protected class Xpto extends Abc").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classJava.get_class("     abstract class Xpto extends Abc").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classJava.get_class("     public abstract class Xpto extends Abc").name
      expect(classNameCaptured).to eq("Xpto")      

      classNameCaptured = @classJava.get_class("     public static class Xpto extends Abc").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classJava.get_class("     public final class Xpto extends Abc").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class inheritance with whitespace between extends." do
      classNameCaptured = @classJava.get_class("class Xpto   extends Abc").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classJava.get_class("public class Xpto   extends Abc").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classJava.get_class("private class Xpto   extends Abc").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classJava.get_class("protected class Xpto   extends Abc").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classJava.get_class("abstract class Xpto   extends Abc").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classJava.get_class("public abstract class Xpto   extends Abc").name
      expect(classNameCaptured).to eq("Xpto")      

      classNameCaptured = @classJava.get_class("public static class Xpto   extends Abc").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classJava.get_class("public final class Xpto   extends Abc").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class inheritance with many whitespace." do
      classNameCaptured = @classJava.get_class("   class   Xpto extends Abc ").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classJava.get_class("   public class   Xpto extends Abc ").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classJava.get_class("   private class   Xpto extends Abc ").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classJava.get_class("   protected class   Xpto extends Abc ").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classJava.get_class("   final class   Xpto extends Abc ").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classJava.get_class("   public final class   Xpto extends Abc ").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classJava.get_class("   private final class   Xpto extends Abc ").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classJava.get_class("   protected final class   Xpto extends Abc ").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class inheritance with many whitespace between extends." do
      classNameCaptured = @classJava.get_class("class Xpto      extends    Abc").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classJava.get_class("public class Xpto      extends    Abc").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classJava.get_class("private class Xpto      extends    Abc").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classJava.get_class("protected class Xpto      extends    Abc").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classJava.get_class("static class Xpto      extends    Abc").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classJava.get_class("public static class Xpto      extends    Abc").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classJava.get_class("private static class Xpto      extends    Abc").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classJava.get_class("protected static class Xpto      extends    Abc").name
      expect(classNameCaptured).to eq("Xpto")
    end

    it "Class inheritance with whitespace in the corners." do
      classNameCaptured = @classJava.get_class("  class   Xpto extends Abc   ").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classJava.get_class("  public class   Xpto extends Abc   ").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classJava.get_class("  private class   Xpto extends Abc   ").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classJava.get_class("  protected class   Xpto extends Abc   ").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classJava.get_class("  abstract class   Xpto extends Abc   ").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classJava.get_class("  public abstract class   Xpto extends Abc   ").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classJava.get_class("  private abstract class   Xpto extends Abc   ").name
      expect(classNameCaptured).to eq("Xpto")

      classNameCaptured = @classJava.get_class("  protected abstract class   Xpto extends Abc   ").name
      expect(classNameCaptured).to eq("Xpto")
    end
  end

  after :all do
    @classJava = nil
  end

end