class SingleLineConditional

  def initialize(pFunctionName)
    return nil if pFunctionName.nil? or !pFunctionName.is_a? String
  end

  def killTest(name)
    puts "me" if name.nil? or age.is_a? String
  end

  def mixed(value)
    puts 'lala' unless 5 > 10
    puts 'lulu' if 300 > value
    ternary = (value < 300) ? 'yes' : 'no'
    x = 30 if 'a' > 'b' or 'c' < value
  end

end

def outside(value)
  puts value if 5 < value
  return nil unless value.nil?
end
