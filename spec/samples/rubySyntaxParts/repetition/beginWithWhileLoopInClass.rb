class Xpto
  def abc
    $i = 0
    $num = 5
    begin
      puts("Inside the loop i = #$i" )
        $i +=1
    end while $i < $num
  end
end
