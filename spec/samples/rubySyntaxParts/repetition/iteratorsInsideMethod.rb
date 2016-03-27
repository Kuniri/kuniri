class Sample1

  def method1
    x = [1,2,3,4,5,6,7]
    x.each do |element|
      puts element
    end

    x.map do |element|
      element + 33
    end

    puts "test.each do |x|"

    x.collect do |element|
      element + 777
    end

    puts demonstrate_block(1) do |number|
      number + 1
    end

  end

  def block_test(number)
    yield(number)
  end

end
