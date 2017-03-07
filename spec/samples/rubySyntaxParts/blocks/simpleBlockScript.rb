5.times do |x|
  puts "#{x} values"
end

x = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
x.each do |theValue|
  if theValue == 3
    puts "3"
  end
end

x.map do |ahhhh|
  ahhhh = ahhhh + 3
end
