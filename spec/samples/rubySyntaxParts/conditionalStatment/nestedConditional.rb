def nested_conditional
  if xpto == "level0"
    y = 12
    if abc == "level1"
      puts "wtf?"
    end
  end

  if xyz == "level0"
    k = "bla"
    if abc == "level1"
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
  if xpto == "level0"
    if abc == "level1"
      if xyz == "level2"
        if arroba == "level3"
          puts "Finally"
        else
          puts "almost..."
        end
      elsif jay == "level2"
        puts "niceeee"
      end
    end
  end
end
