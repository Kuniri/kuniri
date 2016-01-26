class ConstructorWithMixRepetition

  def initialize
    for level0 in 0..5
      i += 1
    end

    until level0 > 30 do
      i += 20
    end

    for level0 in 0..5
      until level1 > 300 do
        for level2 in 0..300 do
          i += 200
        end
      end
    end

  end

end
