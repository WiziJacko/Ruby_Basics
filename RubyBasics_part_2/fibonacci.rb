# Заполнить массив числами фибоначчи до 100

fib = [0, 1]

loop do
  next_fib_number = fib[-1] + fib[-2]
  break if next_fib_number > 100
  fib << next_fib_number
end

puts fib
