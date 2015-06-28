class SimpleClass1

  def method1
    if x > 3
      x = 4
    end
  end

  def method2 (b, c)
    if b && c
      u = 89
    end
  end

  def method3 (b)
    if b == 3
      u = 9
    elsif b < 7
      u = 200
    else
      k = 0
    end
  end

  def method4 (x)
    unless x
      i = 9
    end
  end

  def method5 (y)
    case y
      when 5
        return 8
      when 3
        return 's'
      else
        return 2
    end
  end

end
