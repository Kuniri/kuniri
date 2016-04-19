class FunctionAbstract

  attr_accessor :type

  def initialize(pFunctionName)
    return nil if pFunctionName.nil? or !pFunctionName.is_a? String

    @name = pFunctionName
    @visibility = "public"
    @manager = String.new
  end

  def killTest(name)
    if name.nil? or age.is_a? String
      puts "me"
    end
  end

end
