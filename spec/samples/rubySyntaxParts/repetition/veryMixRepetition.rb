def veryMixConditional

  level0 = 0

  for level0 in 0..5
    puts "value #{i}"
  end

  until level0 > $num do
    puts "something"
  end

  while level0 < $num do
    i += 1
  end

  for level0 in 0..5
    i += 10
    until level1 > level0 do
      i += level0
      while level2 > 8 do
        i += 33
      end
    end
  end

end

