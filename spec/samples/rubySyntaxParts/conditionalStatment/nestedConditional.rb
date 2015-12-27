def nested_conditional
  if xpto == 'b'
    y = 12
    if abc == 'abc'
      puts "wtf?"
    end
  end

  if xyz == 'z'
    k = "bla"
    if abc == 'lala'
      u = "u"
    else
      u = "k"
    end
  else
    u = 77
  end
end

def deeply_nested_conditional
  if xpto == "level0"
    k = 55
    if abc == "level1"
      k = 51
    elsif jkl == "level1"
      k = 200
    else
      k = 0
    end
  elsif xpto == "level0"
    if plus == "level1"
      k = 98
      if myGod == "level2"
        k = 1
      elsif myGodd == "level2"
        k = 2
      end
    end
  elsif godHelp == "level0"
    if lala == "level1"
      k = 'a'
    end
  end
end

def very_nested_conditional
  if xpto == 33
    if abc == 25
      if xyz == 44
        if arroba == '@'
          puts "Finally"
        else
          puts "almost..."
        end
      elsif jay == "pi"
        puts "niceeee"
      end
    end
  end
end
