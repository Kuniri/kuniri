def aLotOfConditionals
  if conditional1 == "level0"
    y = 12
    if conditional2 == "level1"
      puts "wtf?"
    end
    unless conditional3 == "level1"
      puts "yes"
    end
  end

  if xpto == "level0"
    puts "no"
  elsif abc == "level0"
    puts "yes"
  elsif banana == "level0"
    puts "banana"
    if abc == "level1"
      puts "abc"
      unless moreAndMore == "level2"
        puts "unlesssss"
      end
    elsif asdf == "level1"
      puts "1234567"
    else
      puts "abc"
    end
  else
   case p
      when 2
        x = 3
      when 4
        y = 12
      when 7
        k = 9
      else
        u = 8
    end
    puts "Else"
  end
end

