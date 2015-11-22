=begin
Executes code while conditional is false. An until statement's conditional is
separated from code by the reserved word do, a newline, or a semicolon.
ref: http://www.tutorialspoint.com/ruby/ruby_loops.htm
=end
class Xpto
  def abc
    $i = 0
    $num = 5

    until $i > $num  do
      puts("Inside the loop i = #$i" )
        $i +=1;
    end
  end
end
