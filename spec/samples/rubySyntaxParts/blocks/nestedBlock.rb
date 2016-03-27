class MoreComplexTest

  attr_accessor :values, :valuesWithElement

  def initialize
    @values = [[1, 2, 3, 4], [1, 2, 3, 4, 5, 6], [1, 3, 4, 5, 6, 7, 8, 9]]
    @valuesWithElement = [[1, 2, 3, 4], [1, 2, 3, 4, 5, 6], [1, 3, 4, 5, 6, 7, 8, 9], 10, 0]
  end

  def first
    @valuesWithElement.each do |arrayElement|
        @arrayElement.each do |value|
          puts value
        end
    end
  end

  def justForCheckTheEnd
    if "Yes, I'm in the end"
      puts "yes"
    end
  end

end
