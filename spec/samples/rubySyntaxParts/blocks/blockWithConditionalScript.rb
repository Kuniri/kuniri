25.times do |x|
  if x % 2 == 0
    puts "#{x} yessss"
  elsif x > 9
    puts "#{x} - ehhh"
  else
    puts "#{x} = noooo"
  end
end

x = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
x.each do |theValue|
  if theValue == 3
    puts "3"
  end
end

[1, 2, 3].each do |n|
  puts "Number #{n}"
end

[1, 2, 3].each {|n| puts "Number #{n}"}

def twice_do(&proc)
  2.times { proc.call() } if proc
end
twice_do { puts "OK 1" }

def thrice_do()
  3.times { yield } if block_given?
end
thrice_do { puts "OK 2" }
