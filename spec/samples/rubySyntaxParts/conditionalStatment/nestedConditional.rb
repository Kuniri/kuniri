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
  if xpto == "xpto"
    k = 55
    if abc == "abc"
      k = 51
    elsif jkl == 99
      k = 200
    else
      k = 0
    end
  elsif xpto == "arroz"
    if plus == "feijao"
      k = 98
      if myGod == 1
        k = 1
      elsif arghh
        k = 2
      end
    end
  elsif godHelp == "God help?"
    if lala == "lala"
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
