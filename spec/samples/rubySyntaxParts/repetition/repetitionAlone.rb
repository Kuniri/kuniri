i = 20
num = 30

for i in 0..5
  puts "Value of local variable is #{i}"
end

until i > num  do
  puts("Inside the loop i = ")
  i += 1;
end

for i in 0..5
  puts "Value of local variable is"
end

begin
  puts("Inside the loop i = " )
  i += 1
end while i < num

