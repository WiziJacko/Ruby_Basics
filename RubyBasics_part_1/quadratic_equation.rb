puts "Вычисляем квадратно уравнение"

print "Введите значение коэффициента A: "
a = gets.chomp.to_f
print "Введите значение коэффициенрта B: "
b = gets.chomp.to_f
print "Введите значение коэффициента C: "
c = gets.chomp.to_f

d = b**2 - (4.0 * a * c)

if d > 0
  root_of_d = Math.sqrt(d)
  x1 = (- b + root_of_d) / (2.0 * a)
  x2 = (- b - root_of_d) / (2.0 * a)
  puts "Уравнение имеет два корня: #{x1} и #{x2}"
elsif d == 0
  x1 = - b / (2.0 * a)
  puts "Уравнение имеет один корень: #{x1}"
else
  puts "Уравние не имеет корней"
end
