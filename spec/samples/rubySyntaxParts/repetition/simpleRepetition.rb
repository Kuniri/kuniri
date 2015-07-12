class SimpleClass

  def simple1
    i = 0
    num = 5

    while i < num  do
       i += 1
    end
  end

  def simple2 (i, num)
    until i > num  do
      puts("Inside the loop i = ")
      i += 1;
    end

    for i in 0..5
      puts "Value of local variable is"
    end

    begin
      puts("Inside the loop i = " )
      i += 1
    end while i < num
  end

end
