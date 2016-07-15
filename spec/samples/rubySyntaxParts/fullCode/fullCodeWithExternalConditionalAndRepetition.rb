$abc = ARGV[0].to_i
$lala = ARGV[1].to_i
y = [1,2,3,4,5]

if $abc > 3
  puts 'lululu'
else
  puts 'lalala'
end

for i in y
  puts i
end

@globalVariable

# This is a simple test
# with class comment :)
class Abc < Array

  # This is a comment in the constructor
  def initialize

    if (x < 3)
      return x
    end

    for i in x
    end

  end

  def method0
    @attributeInsideMethod
  end

  # Niceeeeee... now it is your time :)
  def method1
        while condition do

        end
  end

  def method2 (x)
        for i in x
        end
  end

  def method3 (a, b, c)
        if (a==0)
                return b < c
        end
  end

  # Method4 :)
  def method4 (ab)
    if (k == y)
      return k
    else
      return y
    end
  end

=begin
  Ahhhhh this is other kind of comments! :)
=end
  def method5
    if (y or k)
      return 3
    end
    while condition do
      puts "abc"
    end
  end

  @attribute1

end

xyz = 'youuuu'
abc = 'not meee'
u = k = 'j'
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

$i = 390
$num = 32
while $i < $num  do
   puts("Inside the loop i = #$i" )
   $i +=1
end

x = k = level1 = level2 = level3 = level4 = 3
for level0 in 8..19 do
  if level1 > 10
    x = 20
    while level2 do
      k = 222
      unless level3
        until level4 < 20 do
          puts "this is the end"
        end
      end
    end
  end
end
