class MethodWithMixConditional

  def methodTest
   case p
      when 2
        if xpto == "level1"
          puts "ayhh"
        else
          puts "ooooo"
        end
      when 4
        if xpto1 == "level1"
          if xpto2 == "level2"
            if xpto3 == "level3"
              puts "xpto"
            elsif abc == "level3"
              puts "abc"
            else
              puts "llll"
            end
          end
        elsif banana == "level1"
          puts "banana"
        end
      when 7
        unless abc == "level1"
          if xpto == "level2"
            case x
              when 6
                puts "6"
              when 7
                puts "7"
            end
          end
        end
      else
        u = 8
    end
  end

end
